{ config, pkgs, lib, ... }:
{
  environment.etc.hosts.mode = "0644";
  environment.systemPackages = [
    pkgs.kubefwd
    pkgs.istio
  ];
}
