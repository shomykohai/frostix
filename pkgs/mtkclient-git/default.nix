{
  pkgs,
  lib,
  python3,
  fetchFromGitHub,
  makeDesktopItem,
}:

let
  # TODO: Remove this override once nixpkgs updates unstable
  mfusepy' = python3.pkgs.mfusepy.overridePythonAttrs (oldAttrs: {
    postPatch = ''
      substituteInPlace pyproject.toml --replace-fail '"setuptools >= 61, < 83"' '"setuptools >= 61"'
    ''
    + (oldAttrs.postPatch or "");
  });
in
python3.pkgs.buildPythonPackage {
  pyproject = true;
  pname = "mtkclient-git";
  version = "2.1.4+0542a87";

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
    mfusepy'
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
    rev = "0542a8729993000661e2325e838217ee754d1632";
    hash = "sha256-sl6u9HbJmUCuAeKhd1qwpceBqa88nekgpTVXvZ6Rd4o=";
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
