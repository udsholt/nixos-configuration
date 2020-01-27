{ config, pkgs, lib, ... }:
let
  secrets = import ../../secret;
in
{
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

    mercurial

    psmisc   # pstree, killall etc.
    binutils # ld etc.
    pciutils # lspci etc.
    dnsutils # nslookup, dig, etc.

    pwgen
    mkpasswd

    firefox
    vscodium
    vscode-with-extensions
    slack
    sublime

    shared_mime_info
    libnotify

    utilties

    foreman
    kubefwd
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

  environment.etc.hosts.mode = "0644";
}

