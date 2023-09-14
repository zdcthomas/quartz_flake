{
  description = "Quartz static site";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    quartz-src = {
      url = "github:jackyzha0/quartz/v4";
      flake = false;
    };
    content = {
      url = "path:./content/";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    quartz-src,
    content,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = rec {
      default = pkgs.buildNpmPackage {
        name = "quartz";
        npmDepsHash = "sha256-NKrAfbPyhCYascM+p5M+o3GUw65RuspRMNmaxcOE68Y=";
        src = quartz-src;
        dontNpmBuild = true;

        installPhase = ''
          runHook preInstall
          npmInstallHook
          cd $out/lib/node_modules/@jackyzha0/quartz
          cp ${content}/* ./content
          $out/bin/quartz build
          mv ./public $out/public
          runHook postInstall
        '';
      };
    };
  };
}
