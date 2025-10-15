{
  lib,
  python3,
  fetchFromGitHub,
}: let
  liblk = python3.pkgs.buildPythonPackage {
    pname = "liblk";
    version = "3.0.2";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "liblk";
      rev = "96ccd9e0167fe08bea5e0fcfa5b33d0a4568cb52";
      hash = "sha256-cTN2a963m6uRlpdIZsExeKhsoqFfcBl2rmlRJZF3ykk=";
    };

    pyproject = true;

    build-system = [python3.pkgs.setuptools];
  };
in
  python3.pkgs.buildPythonPackage {
    pyproject = true;
    pname = "lkpatcher";
    version = "4.0.2";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "lkpatcher";
      rev = "019fa0eb591d4910df62d65c60da5ee01044b246";
      hash = "sha256-XGnYVf38K+1dk+1Psjnop6c1sfxxzb+wnPuCjVtoa+A=";
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
