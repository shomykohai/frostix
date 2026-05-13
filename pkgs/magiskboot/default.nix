{
  stdenvNoCC,
  lib,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "magiskboot";
  version = "0-unstable-2025-10-21";

  src = fetchFromGitHub {
    owner = "magojohnji";
    repo = "magiskboot-linux";
    rev = "56c02e4ceeb39cce5cff77a3135fd5c2c111e7fd";
    hash = "sha256-9bXkzM9oiY89Ur5r41TQtLN3IRlyZqV2wp9Xb9+0dg0=";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp "$src/x86_64/magiskboot" $out/bin/
    chmod +x $out/bin/magiskboot
  '';

  meta = {
    description = "Boot Image Modification Tool";
    homepage = "https://github.com/magojohnji/magiskboot-linux";
    license = lib.licenses.gpl3Only;
  };
}
