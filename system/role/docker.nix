{ config, pkgs, lib, ... }:
{
  users.users.udsholt.extraGroups = ["docker"];

  virtualisation.docker.enable = true;
  environment.systemPackages = with pkgs; [
    pkgs.docker_compose
  ];
}

