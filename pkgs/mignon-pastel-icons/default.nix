{ lib, fetchFromGitHub, stdenvNoCC, gtk3 }:

let
  version = "unstable-2026-08-22";

  src = fetchFromGitHub {
    owner = "igorfmoraes";
    repo = "Mignon-icon-theme";
    rev = "7a7ea5768f2826ca7e54eedf2aefa72092ab6fba";
    hash = "sha256-AKFRZngtjZ23/75j9TMIdPerp5J8JL7NQyDE/DwBMLM=";
  };

  mkTheme = { variant ? "", appsDir, themeName, prettyName }:
    stdenvNoCC.mkDerivation {
      pname = "mignon-icon-theme${lib.optionalString (variant != "") "-${variant}"}";
      inherit version src;

      nativeBuildInputs = [ gtk3 ];
      dontDropIconThemeCache = true;

      installPhase = ''
        runHook preInstall

        mkdir -p "$out/share/icons"

        local finalName="${themeName}"
        if [ -n "${variant}" ]; then
          finalName="${themeName}-${variant}"
        fi

        install -Dm644 src/index.theme "$out/share/icons/$finalName/index.theme"

        mkdir -p "$out/share/icons/$finalName/scalable"
        cp -r "${appsDir}" "$out/share/icons/$finalName/scalable/apps"
        cp -r src/scalable/devices "$out/share/icons/$finalName/scalable/"
        cp -r src/scalable/mimetypes "$out/share/icons/$finalName/scalable/"
        cp -r src/scalable/places "$out/share/icons/$finalName/scalable/"
        cp -r links/scalable "$out/share/icons/$finalName/"

        find "$out/share/icons/$finalName" -type l ! -exec test -e {} \; -delete

        ln -s "$out/share/icons/$finalName/scalable" \
          "$out/share/icons/$finalName/scalable@2x"

        sed -i \
          -e 's/%INHERITS%/Adwaita,Yaru,Cosmic,Pop,Mint-Y-Blue,breeze,breeze-dark,hicolor/' \
          -e "s/%NAME%/${prettyName}/" \
          "$out/share/icons/$finalName/index.theme"

        find "$out/share/icons/$finalName" -type f -name '*.svg' \
          -exec sed -i 's/#5294e2/#99C0ED/g' {} +

        gtk-update-icon-cache "$out/share/icons/$finalName"

        runHook postInstall
      '';

      meta = {
        homepage = "https://github.com/igorfmoraes/Mignon-icon-theme";
        description = "Flat pastel icon theme";
        license = lib.licenses.gpl3;
        platforms = lib.platforms.linux;
      };
    };
in
mkTheme {
  appsDir = "src/scalable/apps";
  themeName = "Mignon-pastel";
  prettyName = "Mignon pastel";
} // {
  light = mkTheme {
    variant = "light";
    appsDir = "src/scalable/apps-light";
    themeName = "Mignon-pastel";
    prettyName = "Mignon pastel light";
  };

  dark = mkTheme {
    variant = "dark";
    appsDir = "src/scalable/apps-dark";
    themeName = "Mignon-pastel";
    prettyName = "Mignon pastel dark";
  };
}
