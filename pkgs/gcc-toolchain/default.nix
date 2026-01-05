{pkgs}:
# import all individual toolchain files
let
  gcc_aarch64_embedded = pkgs.callPackage ./gcc-aarch64-embedded {};
  gcc_aarch64_linux = pkgs.callPackage ./gcc-aarch64-linux-gnu {};
  gcc_arm_linux = pkgs.callPackage ./gcc-arm-linux-gnueabihf {};
  gcc_arm_linux_12 = pkgs.callPackage ./gcc-arm-linux-gnueabihf-12 {};
in {
  gcc-aarch64-embedded = gcc_aarch64_embedded;
  gcc-aarch64-linux-gnu = gcc_aarch64_linux;
  gcc-arm-linux-gnueabihf = gcc_arm_linux;
  gcc-arm-linux-gnueabihf-12 = gcc_arm_linux_12;
}
