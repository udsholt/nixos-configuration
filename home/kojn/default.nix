# https://rycee.gitlab.io/home-manager/options.html

{ pkgs, lib, secrets, ... }:
{
  # zsh
  programs.zsh.enable = true;
  programs.zsh.oh-my-zsh.enable = true;
  programs.zsh.oh-my-zsh.custom = "${pkgs.oh-my-zsh-custom}"; # requires a package to place in folders
  programs.zsh.oh-my-zsh.theme = "red";

  # git
  programs.git.enable = true;
  programs.git.userName = secrets.name;
  programs.git.userEmail = secrets.email;
  programs.git.extraConfig.core.editor = "nvim";
  programs.git.includes = [
    { path = "~/.config/git/custom"; }
  ];

  # direnv
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  # i3
  # missing xeventind for resize
  xsession.windowManager.i3.enable = true;
  xsession.windowManager.i3.package = pkgs.i3-gaps;
  xsession.windowManager.i3.config.modifier = "Mod4"; # windows key
  xsession.windowManager.i3.config.fonts = ["DejaVu Sans 9"];
  xsession.windowManager.i3.config.gaps = {
    inner = 5;
    outer = 0;
  };

  xsession.windowManager.i3.config.bars = [{
    fonts = ["DejaVu Sans 9"];
  }];

  # found example: github.com/tuxinaut/nix-home
  xsession.windowManager.i3.config.keybindings = lib.mkOptionDefault {
    "Mod4+Return" = "exec ${pkgs.sakura}/bin/sakura";
    "Mod4+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
  };

  # rofi
  # rofi.show-icons:      false
  # rofi.modi:            drun,run,window,ssh
  # rofi.lines:           7
  # rofi.line-padding:    10
  # rofi.matching:        fuzzy
  # rofi.bw:              0
  # rofi.padding:         0
  # rofi.separator-style: none
  # rofi.hide-scrollbar:  true
  # rofi.line-margin:     0
  # rofi.font:            DejaVu Sans 9
  # rofi.theme:           @theme@
  programs.rofi.enable = true;
  programs.rofi.theme = "${./rofi/arc-red-dark.rasi}"; # this just works, cool!

  # sakura
  # https://github.com/rycee/home-manager/issues/871
  xdg.configFile."sakura/sakura.conf".source = "${./sakura/sakura.conf}";
}