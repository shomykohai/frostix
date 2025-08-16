{pkgs ? import <nixpkgs> {}}: {
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib {inherit pkgs;}; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  ferroxide = pkgs.callPackage ./pkgs/ferroxide {};
  kde-plasma-control-hub = pkgs.callPackage ./pkgs/kde-plasma-control-hub {};
  kde-plasma-flex-hub = pkgs.callPackage ./pkgs/kde-plasma-flex-hub {};
  mtkclient-git = pkgs.callPackage ./pkgs/mtkclient-git {};
  dexpatcher = pkgs.callPackage ./pkgs/dexpatcher {};
  dex2jar = pkgs.callPackage ./pkgs/dex2jar {};
}
