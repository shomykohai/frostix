{
  pkgs,
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pyproject = true;
  pname = "mtkclient-git";
  version = "2.1.2-094113b";

  buildInputs = with pkgs; [
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
    rev = "094113b8d328187a2dc0e0712dc12d4f5677d9af";
    hash = "sha256-mbfuOYJvwHfDvjTtAgMBLi7REIRRcJ9bhkY5oVjxCAM=";
  };

  postInstall = ''
    mkdir -p $out/etc/udev/rules.d
    cp $src/Setup/Linux/50-android.rules $out/etc/udev/rules.d/50-android.rules
    cp $src/Setup/Linux/51-edl.rules $out/etc/udev/rules.d/51-edl.rules
  '';

  meta = {
    description = "MTK reverse engineering and flash tool";
    homepage = "https://github.com/bkerler/mtkclient";
    license = lib.licenses.gpl3Only;
  };
}
