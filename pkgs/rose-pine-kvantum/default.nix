{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rose-pine-kvantum";
  version = "0-unstable-2025-04-16";

  src = fetchFromGitHub {
    owner = "rose-pine";
    repo = "kvantum";
    rev = "48edf9e2d772b166ed50af3e182a19196e5d3fe6";
    hash = "sha256-0xSMYYPsW7Rw5O8FL0iAt63Hya8GkI2VuOZf64PewyQ=";
  };

  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/Kvantum
    for i in $(find . -iname "*.tar.gz"); do
        tar -xf $i -C $out/share/Kvantum
    done

    runHook postInstall
  '';

  meta = {
    description = "Soho vibes for Kvantum";
    homepage = "https://github.com/rose-pine/kvantum";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
  };
})
