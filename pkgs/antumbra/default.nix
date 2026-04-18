{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "antumbra";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "shomykohai";
    repo = "penumbra";
    tag = "v${finalAttrs.version}";
    hash = "sha256-6Edm0ZWezd6nSxOVMhtiSVamiKp7mVeOyGHrc5J34p8=";
  };

  cargoHash = "sha256-Zdb/3/EDOb+yjyNKocQeBaXWDqwkTCusqG1C8wCh2qI=";
  doCheck = false;

  meta = {
    description = "🌘 MTK flash tool written in rust";
    homepage = "https://github.com/shomykohai/penumbra";
    license = lib.licenses.agpl3Plus;
  };
})
