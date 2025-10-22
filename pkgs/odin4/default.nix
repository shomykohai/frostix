{
  lib,
  stdenv,
  fetchurl,
  patchelf,
  glibc,
}:
stdenv.mkDerivation {
  pname = "odin4";
  version = "1.2.1";

  src = fetchurl {
    url = "https://gitlab.com/leahh/leahs-overlay/-/raw/main/app-mobilephone/odin4-bin/files/odin4-1.2.1.tar.gz";
    sha256 = "sha256-urGO9oq/60P2wAHRZPLfW513ZR6nYJr3n67DbNfbkx4=";
  };

  nativeBuildInputs = [patchelf];
  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp odin4 $out/bin/odin4

    patchelf --set-interpreter ${glibc}/lib/ld-linux-x86-64.so.2 \
             --set-rpath ${glibc}/lib $out/bin/odin4
  '';

  meta = {
    description = "Odin v4 is Samsung's tool used to flash firmware to Samsung devices through \"Download Mode\".";
    homepage = "https://gitlab.com/leahh/leahs-overlay";
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
