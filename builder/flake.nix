{
  description = "Quartz static site";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    quartz-src = {
      url = "github:jackyzha0/quartz/v4";
      flake = false;
    };
    language-servers.url = git+https://git.sr.ht/~bwolf/language-servers.nix;
    language-servers.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    quartz-src,
    language-servers,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        packages = rec {
          default = pkgs.buildNpmPackage {
            name = "quartz";
            npmDepsHash = "sha256-NKrAfbPyhCYascM+p5M+o3GUw65RuspRMNmaxcOE68Y=";
            src = quartz-src;
            dontNpmBuild = true;

            installPhase = ''
              runHook preInstall
              npmInstallHook
              cd $out/lib/node_modules/@jackyzha0/quartz
              rm -rf ./content
              mkdir content
              cp -r ${./content}/* ./content
              $out/bin/quartz build
              mv ./public $out/public
              runHook postInstall
            '';
          };
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            nodejs_20
            prettierd
            eslint_d
            language-servers.packages.${system}.typescript-language-server
          ];
        };
      }
    );
}
