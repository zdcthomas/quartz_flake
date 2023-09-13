{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    quartz = {
      url = "github:jackyzha0/quartz/v4";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    quartz,
  }:
    flake-utils.lib.eachDefaultSystem
    (
      system: let
        overlays = [];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        packages.quartz = pkgs.stdenv.mkDerivation rec {
          pname = "quartz";
          src = quartz;
          buildInputs = with pkgs; [
            nodejs_20
          ];
          content = ./content
          buildPhase = ''
            npm i
            npx quartz build
          '';
        };
      }
    );
}
