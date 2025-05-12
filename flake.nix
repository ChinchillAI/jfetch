{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      top@{
        config,
        withSystem,
        moduleWithSystem,
        ...
      }:
      {
        systems = [
          "x86_64-linux"
          "x86_64-darwin"
          "aarch64-linux"
          "aarch64-darwin"
        ];
        perSystem =
          { config, pkgs, ... }:
          {
            packages.jfetch = pkgs.stdenv.mkDerivation {
              pname = "jarch";
              version = "0.0.1";
              src = ./src;
              nativeBuildInputs = [ pkgs.gnumake ];
            };

            apps.jfetch = {
              type = "app";
              program = "${config.packages.jfetch}/bin/jfetch";
            };

            devShells.jfetch = pkgs.mkShell {
              packages = [ pkgs.stdenv ];
            };
          };
      }
    );
}
