.PHONY: switch

secret/default.nix:
	cp secret/default.nix.dist secret/default.nix

switch: secret/default.nix
	sudo nixos-rebuild switch

test: secret/default.nix
	sudo nixos-rebuild test

sync:
	curl -f -o overlay/vscode/generic.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/generic.nix
	curl -f -o overlay/vscode/vscodium.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/vscodium.nix
	curl -f -o overlay/vscode/vscode.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/applications/editors/vscode/vscode.nix

sync-go:
	# until go 1.13 becomes available on stable
	curl -f -o overlay/go/1.13.nix https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/1.13.nix
	curl -f -o overlay/go/setup-hook.sh https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/setup-hook.sh
	curl -f -o overlay/go/remove-tools-1.11.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/remove-tools-1.11.patch
	curl -f -o overlay/go/ssl-cert-file-1.13.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/ssl-cert-file-1.13.patch
	curl -f -o overlay/go/remove-test-pie-1.13.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/remove-test-pie-1.13.patch
	curl -f -o overlay/go/creds-test.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/creds-test.patch
	curl -f -o overlay/go/go-1.9-skip-flaky-19608.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/go-1.9-skip-flaky-19608.patch
	curl -f -o overlay/go/go-1.9-skip-flaky-20072.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/go-1.9-skip-flaky-20072.patch
	curl -f -o overlay/go/skip-external-network-tests.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/skip-external-network-tests.patch
	curl -f -o overlay/go/skip-nohup-tests.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/skip-nohup-tests.patch
	curl -f -o overlay/go//skip-test-extra-files-on-386.patch https://raw.githubusercontent.com/NixOS/nixpkgs/master/pkgs/development/compilers/go/skip-test-extra-files-on-386.patch

home-manager:
	sudo nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
	sudo nix-channel --update home-mananger

