{
  lib,
  python3,
  fetchFromGitHub,
}: let
  liblk = python3.pkgs.buildPythonPackage {
    pname = "liblk";
    version = "3.0.0";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "liblk";
      rev = "7f9e1a459ed5b0877db985455868d1c0ca6bcefc";
      hash = "sha256-TK85jRkbJlj7LXN4q/QaJ6NDXWpwszosqbNSmAKT1FU=";
    };

    pyproject = true;

    build-system = [python3.pkgs.setuptools];
  };
in
  python3.pkgs.buildPythonPackage {
    pyproject = true;
    pname = "lkpatcher";
    version = "4.0.1";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "lkpatcher";
      rev = "13ee931dd8ad7f114a3d1db71c30bc3b2fdb06c3";
      hash = "sha256-kyqiMSt5LLb4WZQjunS/CVCRJrsksWXe8paH4dj3NQI=";
    };

    propagatedBuildInputs = [liblk];
    nativeBuildInputs = [python3.pkgs.setuptools];

    postFixup = ''
      mkdir -p $out/bin
      makeWrapper ${python3.interpreter} $out/bin/lkpatcher \
      --set PYTHONPATH "$PYTHONPATH:${python3.sitePackages}" \
      --add-flags "-m lkpatcher"
    '';

    meta = {
      description = "Streamline tool and module to patch bootloader (LK) images of MTK device(s).";
      homepage = "https://github.com/R0rt1z2/lkpatcher";
      license = lib.licenses.gpl3Only;
    };
  }
