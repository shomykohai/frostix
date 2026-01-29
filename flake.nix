{
  description = "Frostix Nix repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = {
    self,
    nixpkgs,
  }: let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;

    filterDerivationsRec = attrs:
      builtins.foldl' (
        acc: key: let
          val = attrs.${key};
        in
          if nixpkgs.lib.isDerivation val
          then acc // {${key} = val;}
          else if builtins.isAttrs val
          then let
            nested = filterDerivationsRec val;
          in
            if builtins.length (builtins.attrNames nested) > 0
            then acc // {${key} = nested;}
            else acc
          else acc
      ) {} (builtins.attrNames attrs);
  in {
    legacyPackages = forAllSystems (system:
      import ./default.nix {
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      });

    packages =
      forAllSystems (system:
        filterDerivationsRec self.legacyPackages.${system});

    hydraJobs = self.packages;
  };
}
