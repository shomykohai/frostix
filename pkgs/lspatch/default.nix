{
  stdenv,
  lib,
  jre,
  fetchurl,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "lspatch";
  version = "0.8";

  src = fetchurl {
    url = "https://github.com/JingMatrix/LSPatch/releases/download/v${version}/lspatch.jar";
    hash = "sha256-uBCUrD0IiEnZeB4meKh1YpNvjg14xNE2qQctzkD3Igg=";
  };

  nativeBuildInputs = [makeWrapper];

  dontUnpack = true; # Or nix complains

  installPhase = ''
    mkdir -p $out/lib/lspatch
    cp "${src}" $out/lib/lspatch/lspatch.jar

    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/lspatch \
    --add-flags  "-jar $out/lib/lspatch/lspatch.jar"
  '';

  meta = {
    description = "LSPatch: A non-root Xposed framework extending from LSPosed";
    homepage = "https://github.com/JingMatrix/LSPatch";
    license = lib.licenses.gpl3Plus;
  };
}
