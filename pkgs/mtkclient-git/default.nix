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
  version = "2.1.4+60e07f3";

  nativeBuildInputs = [
    python3.pkgs.pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [ "setuptools" ];

  pythonMetadataCheckPhase = "true;";

  buildInputs = [
    pkgs.keystone
  ];

  propagatedBuildInputs = with python3.pkgs; [
    hatchling
    capstone
    colorama
    flake8
    mfusepy
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
    rev = "60e07f3b343a4469389f15967626d63e049968d4";
    hash = "sha256-N8ex1qdhaTvujjhIGg4GUw6ALXPHhvWrvTwWFkXPlBw=";
  };

  pythonImportsCheck = [ "mtkclient" ];

  postInstall = ''
    install -Dm444 Setup/Linux/52-mtk.rules -t $out/lib/udev/rules.d
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "mtkclient";
      desktopName = "MTKClient";
      comment = "Mediatek Flash and Repair Utility";
      exec = "mtk_gui";
      categories = [ "Development" ];
    })
  ];

  meta = {
    description = "MTK reverse engineering and flash tool";
    homepage = "https://github.com/bkerler/mtkclient";
    license = lib.licenses.gpl3Only;
  };
}
