{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs
    act_unstable
  ];
}
