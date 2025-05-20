# Adapted from https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/de/dex2jar/package.nix
{
  lib,
  stdenvNoCC,
  fetchurl,
  jre,
  makeWrapper,
  unzip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dex2jar";
  version = "2.4.27";

  src = fetchurl {
    url = "https://github.com/ThexXTURBOXx/dex2jar/releases/download/${finalAttrs.version}/dex-tools-${finalAttrs.version}.zip";
    hash = "sha256-";
  };

  nativeBuildInputs = [
    makeWrapper
    unzip
  ];

  postPatch = ''
    rm *.bat
    chmod +x *.sh
  '';

  installPhase = ''
    f=$out/share/dex2jar/

    mkdir -p $f $out/bin

    mv * $f
    for i in $f/*.sh; do
      n=$(basename ''${i%.sh})
      makeWrapper $i $out/bin/$n --prefix PATH : ${lib.makeBinPath [ jre ]}
    done
  '';
})
