.PHONY: switch

secret/default.nix:
	cp secret/default.nix.dist secret/default.nix

switch: secret/default.nix
	sudo nixos-rebuild switch

test: secret/default.nix
	sudo nixos-rebuild test


sync:
	# pull vscode from master
	curl -f -o overlay/vscode/generic.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/generic.nixs
	curl -f -o overlay/vscode/vscodium.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/vscodium.nix
	curl -f -o overlay/vscode/vscode.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/vscode.nix