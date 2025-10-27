{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  dexpatcher = pkgs.callPackage ./pkgs/dexpatcher {};
  dex2jar = pkgs.callPackage ./pkgs/dex2jar {};
  ferroxide = pkgs.callPackage ./pkgs/ferroxide {};
  gcc-aarch64-linux-gnu = pkgs.callPackage ./pkgs/gcc-toolchain/gcc-aarch64-linux-gnu {};
  gcc-arm-linux-gnueabihf = pkgs.callPackage ./pkgs/gcc-toolchain/gcc-arm-linux-gnueabihf {};
  kde-plasma-control-hub = pkgs.callPackage ./pkgs/kde-plasma-control-hub {};
  kde-plasma-flex-hub = pkgs.callPackage ./pkgs/kde-plasma-flex-hub {};
  lkpatcher = pkgs.callPackage ./pkgs/lkpatcher {};
  lspatch = pkgs.callPackage ./pkgs/lspatch {};
  mtkclient-git = pkgs.callPackage ./pkgs/mtkclient-git {};
  odin4 = pkgs.callPackage ./pkgs/odin4 {};
  rose-pine-kde = pkgs.callPackage ./pkgs/rose-pine-kde {};
  rose-pine-kvantum = pkgs.callPackage ./pkgs/rose-pine-kvantum {};
}
