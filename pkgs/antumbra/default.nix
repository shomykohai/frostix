{
  lib,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  eudev,
  makeDesktopItem,
  copyDesktopItems,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "antumbra";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "shomykohai";
    repo = "penumbra";
    rev = "3d56d7d3cb7aeaa618171c2b14e8395ad0e1aaa3";
    hash = "sha256-xQGTM+VNeEUSYv8ZzyNsR+10wiahjNBqJvNL2C68n0w=";
  };

  doCheck = false;
  env.RUSTC_BOOTSTRAP = true;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "acon-0.1.0" = "sha256-SS3vU8ewJN5V/oHmjMXb2pOSwMO1wdF1KS98DcxtNMM=";
      "hacc-0.1.0" = "sha256-n+r6lW2ZgqRZQon27bcXholcLLEcCDfe1M1EffIeiwk=";
    };
  };

  postPatch = ''
    cp ${./Cargo.lock} Cargo.lock
  '';

  nativeBuildInputs = [
    pkg-config
    copyDesktopItems
  ];

  buildInputs = [
    eudev
  ];

  desktopItems = [
    (makeDesktopItem {
      name = finalAttrs.pname;
      exec = "${finalAttrs.pname} --tui";
      icon = finalAttrs.pname;
      terminal = true;
      desktopName = "Antumbra";
      genericName = "MediaTek Flash Tool";
      comment = "MediaTek Flash and Servicing Tool";
      categories = [
        "Development"
      ];
    })
  ];

  postInstall = ''
    install -Dm644 tui/res/common/icon.svg $out/share/icons/hicolor/scalable/apps/${finalAttrs.pname}.svg
  '';

  meta = {
    description = "MTK flash tool written in rust";
    homepage = "https://github.com/shomykohai/penumbra";
    license = lib.licenses.agpl3Plus;
  };
})
