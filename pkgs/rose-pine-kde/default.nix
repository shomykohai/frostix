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
    rev = "e09016d12b28254d6e64c9c1ff315a088b1502a4";
    hash = "sha256-sTLbOQBVXG6Oz9Gm0iyvfklkbi8qxtg0C+4k28bf6WA=";
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
