{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rose-pine-kde";
  version = "0-unstable-2025-02-20";

  src = fetchFromGitHub {
    owner = "ashbork";
    repo = "kde";
    rev = "ee9ae80c009f0559c561f61c524e24b80e3af008";
    hash = "sha256-SF2QD8PiBc4fb1ChV/2m+sKOMuFHdNOs3rh/IZyUXVI=";
  };

  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/color-schemes"
    mkdir -p "$out/share/plasma/desktoptheme"

    find . -type f -iname "*.colors" ! -iname "template.colors" -print0 | \
    xargs -0 -I {} cp "{}" "$out/share/color-schemes/"

    find . -type f -iname "*.tar.gz" -print0 | \
    xargs -0 -I {} tar -xf "{}" -C "$out/share/plasma/desktoptheme"

    runHook postInstall
  '';

  meta = {
    description = " Soho vibes for KDE Plasma ";
    homepage = "https://github.com/rose-pine/kde";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
  };
})
