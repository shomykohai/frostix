{
  lib,
  python3,
  fetchFromGitHub,
}: let
  liblk = python3.pkgs.buildPythonPackage {
    pname = "liblk";
    version = "3.0.3";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "liblk";
      rev = "afb2cc1eb2b7bd2c6b51f686183796416df4ed53";
      hash = "sha256-WRyalTiYIvoK09w06c7dW0lkk9FKaW8NLPdzGOhCuT4=";
    };

    pyproject = true;

    build-system = [python3.pkgs.setuptools];
  };
in
  python3.pkgs.buildPythonPackage {
    pyproject = true;
    pname = "lkpatcher";
    version = "4.0.3";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "lkpatcher";
      rev = "f35511087ad93bb000bd99ce8a27dffd73ce722f";
      hash = "sha256-v0nX5Bag5UoP+3Az48CtLJtdZIFwQAXmCQpJuZJVRm4=";
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
