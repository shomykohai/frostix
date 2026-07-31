{
  pkgs,
  lib,
  python3,
  fetchFromGitHub,
  makeDesktopItem,
}:
python3.pkgs.buildPythonPackage {
  pyproject = true;
  pname = "mtkclient-git";
  version = "2.1.4+382fb30";

  pythonMetadataCheckPhase = "true;";

  buildInputs = [
    pkgs.keystone
  ];

  propagatedBuildInputs = with python3.pkgs; [
    hatchling
    capstone
    colorama
    flake8
    fusepy
    keystone-engine
    mock
    pycryptodome
    pycryptodomex
    pyserial
    pyside6
    pyusb
    setuptools
    shiboken6
    unicorn
  ];

  src = fetchFromGitHub {
    owner = "bkerler";
    repo = "mtkclient";
    rev = "382fb302f31c442c5c83d4938ee19640d07b3305";
    hash = "sha256-luTT8yUZDXKdltQVMgj0bnCAFNQoYpGjpP2xRGzGLdY=";
  };

  pythonImportsCheck = ["mtkclient"];

  postInstall = ''
    install -Dm444 Setup/Linux/52-mtk.rules -t $out/lib/udev/rules.d
  '';

  # From nixpkgs!!
  desktopItems = [
    (makeDesktopItem {
      name = "mtkclient";
      desktopName = "MTKClient";
      comment = "Mediatek Flash and Repair Utility";
      exec = "mtk_gui";
      categories = [
        "Development"
      ];
    })
  ];

  meta = {
    description = "MTK reverse engineering and flash tool";
    homepage = "https://github.com/bkerler/mtkclient";
    license = lib.licenses.gpl3Only;
  };
}
