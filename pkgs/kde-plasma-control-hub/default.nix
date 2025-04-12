{
  stdenv,
  lib,
  fetchFromGitHub,
  nix-update-script,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "kde-plasma-control-hub";
  version = "0.7";

  src = fetchFromGitHub {
    owner = "zayronxio";
    repo = "Plasma-Control-Hub";
    rev = "cda73829f37054e85255f83d0ffc6e1bec8e4306";
    hash = "sha256-XVQXI719NYe20ZPkqoUNP1vDxwPnYOjwNGuWSrttFHg=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/plasmoids/Plasma.Control.Hub
    cp metadata.json $out/share/plasma/plasmoids/Plasma.Control.Hub
    cp -r contents $out/share/plasma/plasmoids/Plasma.Control.Hub
    cp -r translate $out/share/plasma/plasmoids/Plasma.Control.Hub

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "KDE Control Hub plasmoid";
    homepage = "https://github.com/zayronxio/Plasma-Control-Hub";
    license = lib.licenses.gpl3Plus;
  };
})
