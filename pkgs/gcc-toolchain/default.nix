{pkgs}:
# import all individual toolchain files
let
  gcc_aarch64_linux = pkgs.callPackage ./gcc-aarch64-linux-gnu {};
  gcc_arm_linux = pkgs.callPackage ./gcc-arm-linux-gnueabihf {};
in {
  gcc-aarch64-linux-gnu = gcc_aarch64_linux;
  gcc-arm-linux-gnueabihf = gcc_arm_linux;
}
