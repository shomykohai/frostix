# ❄️ Frostix
Frostix is my Nix packages repository (based on NUR template)
It mainly contains stuff that I use, and that it wouldn't make sense to add on NUR.

# Installation & Usage

Add frostix to your inputs:

```nix
# flake.nix

{
   inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      frostix = {
         url = "github:shomykohai/frostix";
         inputs.nixpkgs.follows = "nixpkgs";
      };
   };

   outputs = { self, nixpkgs, ... }@inputs:
      let
         system = "x86_64-linux";
         frostix = inputs.frostix.packages.${system};
      in
      {
         ...
         # When inheriting inputs, also add frostix: 
         # { inherit inputs frostix; };
      }
}
```

Then in `environment.systemPackages` or `home.packages` do

```nix
# in configuration.nix
{ config, pkgs, inputs, frostix, ... }:
{
environment.systemPackages = [
   frostix.package-you-want
];
}



# in home.nix
{ config, lib, pkgs, inputs, frostix, ...}:
{
   home.packages = with pkgs; [
      frostix.package-you-want
   ];
}
```

# License

This project is licensed under the [MIT License](LICENSE)

Based on [NUR Template](https://github.com/nix-community/nur-packages-template) (which is also licensed under MIT)
