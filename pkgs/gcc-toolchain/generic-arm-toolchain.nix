{
  lib,
  stdenv,
  fetchurl,
  ncurses6,
  libxcrypt-legacy,
  xz,
  zstd,
  pname,
  version ? "14.3.rel1",
  targetCompiler,
  sha256s,
  description ? "Pre-built GNU toolchain from ARM Cortex-M & Cortex-R processors",
  platformsOverride ? null,
}: let
  urlTemplate = "https://developer.arm.com/-/media/Files/downloads/gnu/${version}/binrel/arm-gnu-toolchain-${version}-${platform}-${targetCompiler}.tar.xz";

  defaultPlatforms = {
    aarch64-darwin = "darwin-arm64";
    aarch64-linux = "aarch64";
    x86_64-linux = "x86_64";
  };

  platforms =
    if platformsOverride != null
    then platformsOverride
    else defaultPlatforms;

  platform = platforms.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  src = fetchurl {
    url = builtins.replaceStrings ["${platform}" "${targetCompiler}" "${version}"] [platform targetCompiler version] urlTemplate;
    sha256 = sha256s.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };
in
  stdenv.mkDerivation {
    inherit pname version src;

    dontConfigure = true;
    dontBuild = true;
    dontPatchELF = true;
    dontStrip = true;

    installPhase = ''
      mkdir -p $out
      cp -r * $out
      rm $out/bin/{${targetCompiler}-gdb-py,${targetCompiler}-gdb-add-index-py} || :
    '';

    preFixup = lib.optionalString stdenv.hostPlatform.isLinux ''
      find $out -type f | while read f; do
        patchelf "$f" > /dev/null 2>&1 || continue
        patchelf --set-interpreter $(cat ${stdenv.cc}/nix-support/dynamic-linker) "$f" || true
        patchelf --set-rpath ${
        lib.makeLibraryPath [
          "$out"
          stdenv.cc.cc
          ncurses6
          libxcrypt-legacy
          xz
          zstd
        ]
      } "$f" || true
      done
    '';

    meta = {
      description = description;
      homepage = "https://developer.arm.com/open-source/gnu-toolchain/gnu-rm";
      license = with lib.licenses; [
        bsd2
        gpl2
        gpl3
        lgpl21
        lgpl3
        mit
      ];
      platforms = builtins.attrNames platforms;
      sourceProvenance = with lib.sourceTypes; [binaryNativeCode];
    };
  }
