.PHONY: switch

secret/default.nix:
	cp secret/default.nix.dist secret/default.nix

switch: secret/default.nix
	sudo nixos-rebuild switch

test: secret/default.nix
	sudo nixos-rebuild test
