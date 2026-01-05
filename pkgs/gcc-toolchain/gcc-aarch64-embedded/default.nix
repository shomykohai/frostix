{callPackage}:
callPackage ../generic-arm-toolchain.nix {
  pname = "gcc-aarch64-embedded";
  targetCompiler = "aarch64-none-elf";
  version = "15.2.rel1";

  platformsOverride = {
    aarch64-linux = "aarch64";
    x86_64-linux = "x86_64";
  };

  sha256s = {
    aarch64-linux = "46195685b6aec1077e3f1b7706b43a6aa1fef4d8d3bff3a411b7dad1c5b1196b";
    x86_64-linux = "66f7ce7c1bf662f589a4caf440812375f3cd8000a033ccf0971127a0726d6921";
  };
}
