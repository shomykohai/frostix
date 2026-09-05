{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mtklogo";
  version = "1.0.1";

  src = fetchFromGitHub {
    owner = "cyberknight777";
    repo = "mtklogo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-vxe7CIh8dR4/D/UnAG4YgxEH23yywtWxc7A73HRjsIU=";
  };

  cargoBuildFlags = ["-p" "mtklogo-cli"];
  cargoHash = "sha256-8Bc3SfEX43HY7fWgqHDQtUBLJOmVGOG+sD227a5BP5c=";
  doCheck = false;

  postInstall = ''
    cp cli/resources/bin/mtklogo.yaml $out/bin/
  '';

  meta = {
    description = "A Rust library and CLI for parsing MTK logo images";
    homepage = "https://github.com/cyberknight777/mtklogo";
    license = lib.licenses.asl20;
  };
})
