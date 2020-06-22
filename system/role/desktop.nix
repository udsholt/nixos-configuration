{ config, pkgs, lib, ... }:
{
  # enabled packages
  environment.systemPackages = with pkgs; [
    neovim

    which
    lsof
    file
    tree
    wget
    curl

    zip
    unzip
    gnumake

    python

    jq
    yq-go

    git
    tig
    gitAndTools.hub

    mercurial

    psmisc   # pstree, killall etc.
    binutils # ld etc.
    pciutils # lspci etc.
    dnsutils # nslookup, dig, etc.

    pwgen
    mkpasswd

    firefox
    vscodium_unstable
    slack
    sublime

    shared_mime_info
    libnotify

    utilties

    #foreman
    #sops
  ];

  # aliases
  environment.shellAliases = {
    vim  = "nvim";
    view = "nvim -R";
  };

  # enable zsh
  programs.zsh.enable = true;

  # enable ssh agent
  programs.ssh.startAgent = true;

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbOptions = "eurosign:e";

  # disable xterm
  services.xserver.desktopManager.xterm.enable = false;
  #services.xserver.desktopManager.default = "none"; # not allowed in 20.03

  # use i3 with gaps
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  #
  services.xserver.displayManager.lightdm.enable = true;

  # use sddm as display manager for now
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.sddm.theme = "maya";



  # slim is removed as of 20.03, a replacement called slim-ng is in the works:
  # * https://github.com/NixOS/nixpkgs/pull/75389
  # * https://github.com/NixOS/nixpkgs/pull/73251
  #
  # use slim as login manager
  #services.xserver.displayManager.slim.enable = true;
  #services.xserver.displayManager.slim.defaultUser = "";
  #services.xserver.displayManager.slim.theme = pkgs.fetchgit {
  #  url = "https://github.com/naglis/slim-minimal.git";
  #  rev = "65759e026e8de1f957889e81ca6faf3b8c2167a7";
  #  sha256 = "0ggkxgx5bdf3yvgfhs594v1h6nkjq6df4kfg5d51jpga0989c28y";
  #};

  # fonts
  fonts.fontconfig.enable = true;
  fonts.fontconfig.allowBitmaps = false;
  fonts.enableFontDir = true;
  fonts.fonts = with pkgs; [
    source-code-pro
    font-awesome
    powerline-fonts
    twemoji-color-font
  ];

  # can't exactly remember
  environment.pathsToLink = [
    "/share/themes"
    "/share/mime"
  ];
}

