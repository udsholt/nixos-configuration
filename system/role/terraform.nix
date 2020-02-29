{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    terraform_0_12_unstable
  ];
}
