{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mtklogo";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "cyberknight777";
    repo = "mtklogo";
    tag = "v${finalAttrs.version}";
    hash = "sha256-9XYo1dtOqA1zH7dewLsLLET/8LM1MQgMTIBItGDpQnY=";
  };

  cargoBuildFlags = ["-p" "mtklogo-cli"];
  cargoHash = "sha256-r881XjVD0p6LpwU3Yx/k0zMGwuN9kmsuVVw0LAfZYRg=";
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
