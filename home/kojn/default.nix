# https://rycee.gitlab.io/home-manager/options.html

{ pkgs, lib, secrets, ... }:
{
  # zsh
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      custom = "${pkgs.oh-my-zsh-custom}"; # requires a package to place in folders
      theme = "red";
    };
  };

  # git
  programs.git = {
    enable = true;
    userName = secrets.name;
    userEmail = secrets.email;
    includes = [ { path = "~/.config/git/custom"; } ];
    extraConfig = {
      core = {
        editor = "nvim";
      };
    };
  };

  # direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  # i3
  # missing xeventind for resize
  xsession.windowManager.i3 = let
    modifier = "Mod4";
    setup = pkgs.mutate ./script/setup-background.sh {
      feh = "${pkgs.feh}";
      img = ./image/red-gradient.jpg; # this does not work with "${...}", why
    };
  in {
    enable = true;
    config = {
      modifier = "${modifier}"; # windows key
      fonts = ["DejaVu Sans 9"];
      gaps = { inner = 5; outer = 0; };
      bars = [
        {
          fonts = ["DejaVu Sans 9"];
        }
      ];

      # found example: github.com/tuxinaut/nix-home
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return" = "exec ${pkgs.sakura}/bin/sakura";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show run";
      };

      startup = [
        { command = "${setup}"; notification = false; }
        { command = "${pkgs.xeventbind} resolution ${setup}"; notification = false; }
      ];
    };
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
  programs.rofi = {
    enable = true;
    theme = "${./theme/rofi/arc-red-dark.rasi}"; # this just works, cool! it requires qoutes
  };

  # sakura
  # https://github.com/rycee/home-manager/issues/871
  xdg.configFile."sakura/sakura.conf".source = "${./config/sakura/sakura.conf}";
}