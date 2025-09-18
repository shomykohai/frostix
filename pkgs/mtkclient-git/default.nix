{
  pkgs,
  lib,
  python3,
  fetchFromGitHub,
}:
python3.pkgs.buildPythonPackage rec {
  pyproject = true;
  pname = "mtkclient-git";
  version = "2.0.2-cf885a3";

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
    rev = "031957d948e1f6ac795c4d1572c37a15bcde192b";
    hash = "sha256-Yx4/ZZDsXoAorysGpO2913+aq6OMwm7ITASGchOvD60=";
  };

  patches = [
    ./udev.patch
    ./carbonara.patch
  ];

  postFixup = ''
    mkdir -p $out/opt/mtkclient
    mv * $out/opt/mtkclient
    # Remove windows stuff
    rm -rf $out/opt/mtkclient/mtkclient/Windows

    # Install udev rules
    ls
    mkdir -p $out/lib/udev/rules.d
    cp $out/opt/mtkclient/mtkclient/Setup/Linux/51-edl.rules $out/lib/udev/rules.d/52-edl.rules
  '';

  meta = {
    description = "MTK reverse engineering and flash tool";
    homepage = "https://github.com/bkerler/mtkclient";
    license = lib.licenses.gpl3Only;
  };
}
