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
    rev = "54b082325fbac7b5b3607ea43f6618d57bd0f71c";
    hash = "sha256-J1JmV9QpkLTjwNrUJW4NkdmxcRj7c6eepy+p8Vgj0xI=";
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
