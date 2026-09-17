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
    rev = "f72152076bb4c0a3fd0f2febefdde40935a2e4c5";
    hash = "sha256-HKOmqxt5Xyvi8UNvSS8OI6swhXwgYOgsg5N+gKEd6vg=";
  };

  doCheck = false;
  env.RUSTC_BOOTSTRAP = true;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "acon-0.1.0" = "sha256-bI2kZsTBM65L3aiwS/DPHtrgKUpZ/fx9o5OJuFMxpwY=";
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
