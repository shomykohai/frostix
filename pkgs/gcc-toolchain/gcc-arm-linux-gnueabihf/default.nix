{callPackage}:
callPackage ../generic-arm-toolchain.nix {
  pname = "gcc-arm-linux-gnueabihf";
  targetCompiler = "arm-none-linux-gnueabihf";

  platformsOverride = {
    aarch64-linux = "aarch64";
    x86_64-linux = "x86_64";
  };

  sha256s = {
    aarch64-linux = "547a618cafac3a587dbaa0d866208987a9d855eefc64012c933560c287f66837";
    x86_64-linux = "3ec0113af5154a2573b3851d74d9e9501a805abf9dfa0f82b04ef26fa0e6fc35";
  };
}
