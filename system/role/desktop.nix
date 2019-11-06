{ config, pkgs, lib, ... }:
let
  secrets = import ../../secret;
in
{
  # import shared modules
  imports = [ ../../module/symlinks ];

  # import custom overlays
  # split into config overlay that uses secrets and packages
  nixpkgs.overlays = [
    (import ../../overlay { inherit secrets; })
  ];

  # enable unfree packages
  nixpkgs.config.allowUnfree = true;

  # enabled packages
  environment.systemPackages = with pkgs; [
    neovim

    which
    lsof
    tree
    wget
    curl

    zip
    unzip
    gnumake

    jq

    git
    tig

    mercurial

    psmisc   # pstree, killall etc.
    binutils # ld etc.
    pciutils # lspci etc.
    dnsutils # nslookup, dig, etc.

    pwgen
    mkpasswd

    firefox
    vscodium

    shared_mime_info

    utilties
  ];

  # enable zsh
  programs.zsh.enable = true;

  # enable ssh agent
  programs.ssh.startAgent = true;

  # user
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
      #".zshrc" = pkgs.config-prezto.zshrc;
      #".zpreztorc" = pkgs.config-prezto.zpreztorc;
      ".zshrc" = pkgs.config-zsh;
      ".gitconfig" = pkgs.config-git;
      ".config/i3/config" = pkgs.config-i3.config;
      ".config/rofi/config" = pkgs.config-rofi;
      ".config/sakura/sakura.conf" = pkgs.config-sakura;
      ".config/VSCodium/User/settings.json" = pkgs.config-codium;
    };
  };

  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.xkbOptions = "eurosign:e";

  # disable xterm
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.default = "none";

  # use i3 with gaps
  services.xserver.windowManager.i3.enable = true;
  services.xserver.windowManager.i3.package = pkgs.i3-gaps;

  # use slim as login manager
  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.defaultUser = "";
  services.xserver.displayManager.slim.theme = pkgs.fetchgit {
    url = "https://github.com/naglis/slim-minimal.git";
    rev = "65759e026e8de1f957889e81ca6faf3b8c2167a7";
    sha256 = "0ggkxgx5bdf3yvgfhs594v1h6nkjq6df4kfg5d51jpga0989c28y";
  };

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

