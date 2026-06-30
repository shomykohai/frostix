{
  lib,
  python3,
  fetchFromGitHub,
}: let
  liblk = python3.pkgs.buildPythonPackage {
    pname = "liblk";
    version = "3.2.0";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "liblk";
      rev = "75c8f14f16457b6c53d950d18d1ed7d2a665bed6";
      hash = "sha256-e1YVOvZPbq5JbCzSfR723iBemcueT4XOh2svhTXpYUU=";
    };

    pyproject = true;

    build-system = [python3.pkgs.setuptools];
    propagatedBuildInputs = [python3.pkgs.pyasn1];
  };
in
  python3.pkgs.buildPythonPackage {
    pyproject = true;
    pname = "lkpatcher";
    version = "4.2.0";

    src = fetchFromGitHub {
      owner = "R0rt1z2";
      repo = "lkpatcher";
      rev = "68034be95401da72ab17251e57d224c0a942d8ad";
      hash = "sha256-DbIYHXVxOyoQEiGIw9+E4zZ0OTE7EWnfRqBC01Cz9Qw=";
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
