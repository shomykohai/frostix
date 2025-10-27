{
  stdenvNoCC,
  fetchFromGitHub,
  lib,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "rose-pine-moonlight-kde";
  version = "0-unstable-2025-10-27";

  src = fetchFromGitHub {
    owner = "shomykohai";
    repo = "rose-pine-kde";
    rev = "dc4940b23da9b4334cddc61c0bedaacd2c4476c0";
    hash = "sha256-qlxxluX9wIzEj7p9xpNhSgHhG/tiyb+XS4x1XGBCZoU=";
  };

  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/color-schemes"
    mkdir -p "$out/share/plasma/desktoptheme"

    find . -type f -iname "*.colors" ! -iname "template.colors" -print0 | \
    xargs -0 -I {} cp "{}" "$out/share/color-schemes/"

    mkdir -p "$out/share/plasma/desktoptheme/rose-pine-moonlight"
    cp -r $src/rose-pine-moon/desktoptheme/* "$out/share/plasma/desktoptheme/rose-pine-moonlight/"

    runHook postInstall
  '';

  meta = {
    description = " Soho vibes for KDE Plasma ";
    homepage = "https://github.com/shomykohai/rose-pine-kde";
    platforms = lib.platforms.linux;
    license = lib.licenses.mit;
  };
})
