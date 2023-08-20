{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    extra-nixpkgs = {
      url = "github:Konecho/my-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    extra-nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      # overlays = [
      #   (self: super: rec {
      #     extras = extra-nixpkgs.packages."${system}";
      #   })
      # ];
    };
    python-packages = ps:
      with ps; [
        python-lsp-server
        autopep8
        black
        jupyterlab

        ch347api
      ];
    python3 = pkgs.python3.override {
      packageOverrides = self: super: rec {
        ch347api = extra-nixpkgs.packages.${system}.ch347api;
      };
    };
    python-with-packages = python3.withPackages python-packages;
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        svls # lsp for SystemVerilog
        verible # verilog formatter
        verilog # icarus verilog
        gtkwave
        verilator
        yosys
        arachne-pnr
        nextpnr
        icestorm

        pulseview # for nanoDLA

        python-with-packages
      ];
    };
  };
}
