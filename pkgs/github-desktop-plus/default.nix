{
  stdenvNoCC,
  lib,
  fetchurl,
  autoPatchelfHook,
  buildPackages,
  gnome-keyring,
  libsecret,
  git,
  curlWithGnuTls,
  nss,
  nspr,
  libxdamage,
  libx11,
  libxscrnsaver,
  libxtst,
  libdrm,
  alsa-lib,
  cups,
  libgbm,
  systemdLibs,
  openssl,
  libglvnd,
  zstd,
  pipewire,
  libei,
  libjpeg8,
}: let
  pkgver = "3.6.3.1";
in
  stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "github-desktop-plus";
    version = pkgver;

    src = let
      urls = {
        "x86_64-linux" = {
          url = "https://github.com/pol-rivero/github-desktop-plus/releases/download/v${pkgver}/DesktopPlus-v${pkgver}-linux-x86_64.deb";
          sha256 = "sha256-xN+gKCxt1zlMNEzWU4Gk9sYt4zxSp+vbf9dieXs/FBc=";
        };
        "aarch64-linux" = {
          url = "https://github.com/pol-rivero/github-desktop-plus/releases/download/v${pkgver}/DesktopPlus-v${pkgver}-linux-arm64.deb";
          sha256 = "sha256-Vbp5LKUSt8YI9wc9U++S7S7aZWmIeXkT4kfQNLMfKbI=";
        };
      };
    in
      fetchurl
      urls."${stdenvNoCC.hostPlatform.system}"
        or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");

    nativeBuildInputs = [
      autoPatchelfHook
      zstd
      (buildPackages.wrapGAppsHook3.override {makeWrapper = buildPackages.makeShellWrapper;})
    ];

    buildInputs = [
      gnome-keyring
      libxdamage
      libx11
      libxscrnsaver
      libxtst
      libsecret
      git
      curlWithGnuTls
      nss
      nspr
      libdrm
      alsa-lib
      cups
      libgbm
      openssl
      pipewire
      libei
      libjpeg8
    ];

    unpackPhase = ''
      runHook preUnpack

      mkdir -p $TMP/github-desktop-plus
      cp $src $TMP/github-desktop-plus.deb
      cd $TMP/github-desktop-plus

      ar x ../github-desktop-plus.deb
      tar --no-same-owner --no-same-permissions -xf data.tar.*

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/{opt,bin,share}
      cp -a usr/share/. $out/share/

      mkdir -p $out/opt/github-desktop-plus
      cp -a usr/lib/desktop-plus/. $out/opt/github-desktop-plus/
      rm -rf $out/opt/github-desktop-plus/resources/app/git
      ln -s ${git} $out/opt/github-desktop-plus/resources/app/git

      rm -rf $out/opt/github-desktop-plus/resources/app/copilot/koffi/build/koffi/{musl_*,openbsd_*,freebsd_*}
      ln -s $out/opt/github-desktop-plus/desktop-plus \
        $out/bin/desktop-plus

      runHook postInstall
    '';

    preFixup = ''
      gappsWrapperArgs+=(
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-wayland-ime=true}}"
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [libglvnd]}
      )
    '';

    runtimeDependencies = [
      systemdLibs
    ];

    meta = with lib; {
      description = "Fork of GitHub Desktop with extra features and improvements";
      homepage = "https://github.com/pol-rivero/github-desktop-plus";
      license = licenses.mit;
      mainProgram = "github-desktop-plus";
      platforms = platforms.linux;
      sourceProvenance = with sourceTypes; [binaryNativeCode];
    };
  })
