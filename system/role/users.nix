{ config, pkgs, lib, ... }:
let
  secrets = import ../../secret;
in
{
  # user
  users.mutableUsers = false;

  # root password
  users.users.root.hashedPassword = secrets.password;

  # udsholt
  users.users.udsholt = rec {
    uid = 1000;
    home = "/home/udsholt";
    shell = "/run/current-system/sw/bin/zsh";
    createHome = true;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    hashedPassword = secrets.password;
  };

  # Using home-manager
  #   https://rycee.gitlab.io/home-manager/
  #
  # Install with:
  #   nix-channel --add https://github.com/rycee/home-manager/archive/release-19.09.tar.gz home-manager
  #   nix-channel --update
  #
  imports = [ <home-manager/nixos> ];

  # udsholt home config
  home-manager.users.udsholt = (import ../../home {
    inherit pkgs;
    inherit lib;
    inherit secrets;
  });
}