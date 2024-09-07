{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		flake-utils.url = "github:numtide/flake-utils";
	};

	outputs = {nixpkgs, ...}@inputs:
		inputs.flake-utils.lib.eachDefaultSystem
		(system:
			let
				pkgs = import nixpkgs { inherit system; };
			in {
				devShells.default = let
					python = pkgs.python3;
				in
				pkgs.mkShell {
					packages = with pkgs; [
						(python.withPackages (ps:
						with ps; [
							pandas
							jax
							jaxlib
							scipy

							matplotlib
						]))

						cargo
						rustc
						rustup
					];
				};
			}
		);
}
