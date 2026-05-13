{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "idmetool";
  version = "2026-05-02-unstable";

  src = fetchFromGitHub {
    owner = "R0rt1z2";
    repo = "idmetool";
    rev = "a18b85facd27392bdf9d5e3f1faeb410d609eaa4";
    hash = "sha256-d+BXPxFoxTX0bHN3zbdf5OJhE3/1MZOqVEflFuG3alA=";
  };

  installFlags = ["PREFIX=$(out)"];

  meta = {
    description = "C tool / library to manipulate Amazon's IDME partition";
    homepage = "https://github.com/R0rt1z2/idmetool";
    license = [
      lib.licenses.bsd3
      lib.licenses.gpl2Only
    ];
    maintainers = [];
    mainProgram = "idmetool";
    platforms = lib.platforms.unix;
  };
})
