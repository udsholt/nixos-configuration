.PHONY: switch

secrets.nix:
	cp secrets.nix.dist secrets.nix

switch: secrets.nix
	sudo nixos-rebuild switch

test: secrets.nix
	sudo nixos-rebuild test