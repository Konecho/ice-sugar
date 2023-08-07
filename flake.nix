{
  description = "A very basic flake";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {system = "x86_64-linux";};
  in {
    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        yosys
        arachne-pnr
        icestorm
        nextpnr
      ];
    };
  };
}
