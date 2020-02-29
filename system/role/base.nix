{ config, pkgs, lib, ... }:
{
  nixpkgs.overlays = [
    (import ../../overlay/unstable)
    (import ../../overlay/custom )
  ];

  nixpkgs.config.allowUnfree = true;
}