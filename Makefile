secret/default.nix:
	cp secret/default.nix.dist secret/default.nix


.PHONY: channels test switch upgrade

channels:
	@echo "Adding nixos-unstable to channels..."
	sudo nix-channel --add https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz nixos-unstable
	sudo nix-channel --update nixos-unstable
	@echo "Adding home-manager to channels..."
	sudo nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
	sudo nix-channel --update home-mananger

test: secret/default.nix
	sudo nixos-rebuild test

switch: secret/default.nix
	sudo nixos-rebuild switch

upgrade: secret/default.nix
	sudo nixos-rebuild switch --upgrade


