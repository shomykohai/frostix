{
  stdenv,
  pkgs,
  lib,
  jre,
  fetchurl,
  makeWrapper
}:

stdenv.mkDerivation rec {
  pname = "dexpatcher";
  version = "1.8.0-beta1";

  src = fetchurl {
    url = "https://github.com/DexPatcher/dexpatcher-tool/releases/download/v1.8.0-beta1/dexpatcher-1.8.0-beta1.jar";
    hash = "1s1r7hshgblsqzm987wzvbgcnq0ivnb5p1q6izc6qjrsklnk2yn1";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/lib/dexpatcher
    cp dexpatcher-${version}.jar $out/lib/dexpatcher/dexpatcher.jar
  
    mkdir -p $out/bin
    makeWrapper ${jre}/bin/java $out/bin/dexpatcher \
    --add-flags  "-jar $out/lib/dexpatcher/dexpatcher.jar"
  '';

  meta = {
    description = "Android Dalvik bytecode patcher.";
    homepage = "https://github.com/DexPatcher/dexpatcher-tool";
    license = lib.licenses.gpl3Plus;
  };
}