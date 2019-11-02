# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  secrets = import ../../secrets.nix;
in
{
  # Enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # Import custom overlays
  nixpkgs.overlays = [
    (import ../../overlay { inherit secrets; })
  ];

  # Import hardware configuration
  imports = [
    ./hardware.nix
    ../../module
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "barnacle";
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Some packages
  environment.systemPackages = with pkgs; [
    vim

    which
    lsof
    tree
    wget
    curl

    zip
    unzip
    gnumake

    git
    tig

    psmisc
    binutils
    pciutils
    dnsutils # nslookup, dig, etc.

    pwgen
    mkpasswd

    firefox
    vscodium
    alacritty
    sakura

    shared_mime_info # contained the missing mime information
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # Setup alacritty as terminal
  environment.variables.TERMINAL = "sakura";

  # Enable zsh
  programs.zsh.enable = true;

  # Enable ssh agent
  programs.ssh.startAgent = true;

  # User
  users.mutableUsers = false;
  users.users.root.hashedPassword = secrets.password;
  users.users.udsholt = rec {
    uid = 1000;
    home = "/home/udsholt";
    shell = "/run/current-system/sw/bin/zsh";
    createHome = true;
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    hashedPassword = secrets.password;
    symlinks = {
      ".zshrc" = pkgs.config-zsh;
      ".gitconfig" = pkgs.config-git;
      ".config/alacritty/alacritty.yml" = pkgs.config-alacritty;
      ".config/i3/config" = pkgs.config-i3.config;
    };
  };

  # Fonts
  fonts.fontconfig.enable = true;
  fonts.fontconfig.allowBitmaps = false;
  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    powerline-fonts
    twemoji-color-font
  ];

  # Can't exactly remember
  environment.pathsToLink = [
    "/share/themes"
    "/share/mime"
  ];

  # NixOS release with version
  system.stateVersion = "19.09";
}

