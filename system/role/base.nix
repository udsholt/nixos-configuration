{ config, pkgs, lib, ... }:
let
  # Allow packages from unstable:
  # https://www.reddit.com/r/NixOS/comments/50njte/install_a_package_from_unstable_while_running/d84xvms/
  unstable = import <nixos-unstable> {};
in {

  # Import custom overlay (with unstable)
  nixpkgs.overlays = [
    (import ../../overlay/unstable { inherit unstable; } )
    (import ../../overlay/custom )
  ];

  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;
}