{
  pkgs,
  lib,
  stdenvNoCC,
  gitRev ? "a44caf771b4cb72f5c2514f7d488455b0fa860d2",
  theme ? "default",
  theme-overrides ? {},
  extraBackgrounds ? [],
}:
stdenvNoCC.mkDerivation (final: {
  pname = "silent";
  version = "${lib.substring 0 8 gitRev}";

  src = pkgs.fetchFromGitHub {
    owner = "uiriansan";
    repo = "SilentSDDM";
    rev = gitRev;
    hash = "sha256-WeoJBj/PhqFCCJEIycTipqPbKm5BpQT2uzFTYcYZ30I=";
  };

  dontWrapQtApps = true;
  dontBuild = true;

  propagatedBuildInputs = builtins.attrValues {
    inherit
      (pkgs.kdePackages)
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
      ;
  };

  installPhase = let
    iniFormat = pkgs.formats.ini {};
    configFile = iniFormat.generate "" theme-overrides;
    basePath = "$out/share/sddm/themes/${final.pname}";

    copyBg = bg: let
      name =
        if lib.isDerivation bg
        then bg.name
        else builtins.baseNameOf bg;
    in "cp ${bg} ${basePath}/backgrounds/${name}";
  in ''
    mkdir -p ${basePath}
    cp -r $src/* ${basePath}

    substituteInPlace ${basePath}/metadata.desktop \
      --replace-warn configs/default.conf configs/${theme}.conf

    chmod +w ${basePath}/configs/${theme}.conf
    ${lib.optionalString (theme-overrides != {}) "ln -sf ${configFile} ${basePath}/configs/${theme}.conf.user"}

    chmod -R +w ${basePath}/backgrounds
    ${lib.concatStringsSep "\n" (map copyBg extraBackgrounds)}
  '';

  meta = {
    description = "A very customizable SDDM theme that actually looks good";
    homepage = "https://github.com/uiriansan/SilentSDDM";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.linux;
  };
})
