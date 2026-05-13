{
  pkgs,
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pyproject = true;
  pname = "mtkclient-git";
  version = "2.1.4-5a863ee";

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
    rev = "5a863eece86fcaa97cb8325cf747e0aae3c307e4";
    hash = "sha256-8Y9tyw+dmhhc4tFo3slr4wQIPXIrmIk/wuCK4aM6oLY=";
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
