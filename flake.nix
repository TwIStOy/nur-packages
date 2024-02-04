{
  description = "Hawtian's NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    (flake-utils.lib.eachDefaultSystem (system: {
      legacyPackages = import ./default.nix {
        pkgs = import nixpkgs {inherit system;};
      };
    }))
    // (flake-utils.lib.eachDefaultSystem (
      system: {
        packages = import ./pkgs {
          pkgs = import nixpkgs {inherit system;};
        };
      }
    ));
}
