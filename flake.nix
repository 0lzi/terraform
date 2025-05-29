{
  description = "Terraform development environment using Nix flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "terraform-shell";

          buildInputs = [
            pkgs.terraform
            pkgs.tflint
            pkgs.terraform-docs
            pkgs.pre-commit
          ];

          shellHook = ''
            echo "🚀 Welcome to your Terraform dev shell!"
            terraform version
          '';
        };
      });
}
