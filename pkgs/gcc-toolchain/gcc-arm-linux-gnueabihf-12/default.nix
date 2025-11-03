{callPackage}:
callPackage ../generic-arm-toolchain.nix {
  pname = "gcc-arm-linux-gnueabihf-12";
  targetCompiler = "arm-none-linux-gnueabihf";
  version = "12.3.rel1";

  platformsOverride = {
    aarch64-linux = "aarch64";
    x86_64-linux = "x86_64";
  };

  sha256s = {
    aarch64-linux = "ac2806f4c1ba772817aded18a5b730b5004592b1f1224d8296de69942e3704bd";
    x86_64-linux = "f5f3c1cfcb429833d363e8fec31bb1282974b119ca8169d6277ce8a549e26d54";
  };
}
