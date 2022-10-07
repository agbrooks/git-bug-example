{
  description = "A flake to illustrate a problem with Nix's built-in git fetcher";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=22.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
       in rec {
         packages.default = pkgs.writeShellScriptBin "which-tag-was-cloned" ''
           echo -e "\e[32m>>> sources came from tag-a! <<<\e[0m"
         '';
         apps.default = flake-utils.lib.mkApp {
           drv = packages.default;
         };
       }
    );
}
