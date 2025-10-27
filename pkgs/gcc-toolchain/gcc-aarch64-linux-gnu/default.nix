{callPackage}:
callPackage ../generic-arm-toolchain.nix {
  pname = "gcc-aarch64-linux-gnu";
  targetCompiler = "aarch64-none-linux-gnu";

  platformsOverride = {
    aarch64-linux = "aarch64";
    x86_64-linux = "x86_64";
  };

  sha256s = {
    aarch64-linux = "7f4ca1d3b773c41b031019d1249b2c58e6beb470eeabacfa0a0813c5e8bb7e5b";
    x86_64-linux = "ddeaff1ea60d4135acba271b0143d9f5add02b68ab9e9be39672d1965c12e82f";
  };
}
