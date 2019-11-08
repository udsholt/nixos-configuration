{ config, pkgs, lib, ... }:
let
  secrets = import ../../secret;
in
{
  # Using home-manager
  #   https://rycee.gitlab.io/home-manager/
  #
  # Install with:
  #   nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
  #   nix-channel --update
  imports = [ <home-manager/nixos> ];

  # experimental user
  users.users.kojn = rec {
    uid = 2000;
    home = "/home/kojn";
    shell = "/run/current-system/sw/bin/zsh";
    createHome = true;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    hashedPassword = secrets.password;
  };

  home-manager.users.kojn = (import ../../home/kojn {
    inherit pkgs;
    inherit lib;
    inherit secrets;
  });

}