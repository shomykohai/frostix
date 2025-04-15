{
  stdenv,
  lib,
  fetchFromGitHub,
  nix-update-script,
  ...
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "kde-plasma-flex-hub";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "zayronxio";
    repo = "Plasma.Flex.Hub";
    rev = "8c89202f394fec58d87b261023ba4012741ec0f2";
    hash = "sha256-YXtV8mUr+fgib44TiTCtu4W2h9gUsLl1rOilGqZQTdo=";
  };


  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/plasma/plasmoids/Plasma.Flex.Hub
    cp metadata.json $out/share/plasma/plasmoids/Plasma.Flex.Hub
    cp -r contents $out/share/plasma/plasmoids/Plasma.Flex.Hub

    runHook postInstall
  '';

  passthru.updateScript = nix-update-script { };

  meta = {
    description = "Plasma Flex Hub is a modular and customizable plasmoid for Plasma 6, evolving from Plasma Control Hub to provide a compact and modern integrated control center.";
    homepage = "hhttps://github.com/zayronxio/Plasma.Flex.Hub";
    license = lib.licenses.gpl3Plus;
  };
})
