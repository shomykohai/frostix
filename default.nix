{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  kde-plasma-control-hub = pkgs.callPackage ./pkgs/kde-plasma-control-hub { };
  mtkclient-git = pkgs.callPackage ./pkgs/mtkclient-git { };
}
