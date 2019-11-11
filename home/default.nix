# https://rycee.gitlab.io/home-manager/options.html

{ pkgs, lib, secrets, ... }:
{
  # zsh
  programs.zsh = {
    enable = true;
    initExtra = ''
    if [ -f ~/.zshlocal ]; then
      source ~/.zshlocal
    fi
    '';
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
    setup = pkgs.mutate ./script/setup-background {
      feh = "${pkgs.feh}";
      img = ./image/red-moon.png; # this does not work with "${...}", why
    };
  in {
    enable = true;
    config = {
      modifier = "${modifier}"; # windows key

      window = {
        titlebar = false;
        border = 1;
      };

      gaps = {
        inner = 5;
        outer = 0;
      };

      fonts = ["DejaVu Sans 9"];
      colors = {
        focused         = { border = "#cd2a37"; background = "#cd2a37"; text = "#ffffff"; indicator = "#ef5408"; childBorder = "#cd2a37"; };
        focusedInactive = { border = "#333333"; background = "#5f676a"; text = "#ffffff"; indicator = "#484e50"; childBorder = "#333333"; };
        unfocused       = { border = "#333333"; background = "#222222"; text = "#888888"; indicator = "#292d2e"; childBorder = "#333333"; };
        urgent          = { border = "#2f343a"; background = "#900000"; text = "#ffffff"; indicator = "#900000"; childBorder = "#2f343a"; };
        placeholder     = { border = "#000000"; background = "#0c0c0c"; text = "#ffffff"; indicator = "#000000"; childBorder = "#0c0c0c"; };
        background      = "#ffffff";
      };

      bars = [
        {
          fonts = ["DejaVu Sans 9"];
          colors = {
            background = "#090909";
            statusline = "#ffffff";
            separator  = "#666666";
            focusedWorkspace  = { border = "#ad242f"; background = "#6b161d"; text = "#ffffff"; };
            activeWorkspace   = { border = "#333333"; background = "#5f676a"; text = "#ffffff"; };
            inactiveWorkspace = { border = "#333333"; background = "#222222"; text = "#888888"; };
            urgentWorkspace   = { border = "#2f343a"; background = "#900000"; text = "#ffffff"; };
            bindingMode       = { border = "#2f343a"; background = "#900000"; text = "#ffffff"; };
          };
        }
      ];

      # found example: github.com/tuxinaut/nix-home
      keybindings = lib.mkOptionDefault {
        "${modifier}+Return"   = "exec ${pkgs.sakura}/bin/sakura";
        "${modifier}+d"        = "exec ${pkgs.rofi}/bin/rofi -show run";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume 0 -5%";
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume 0 +5%";
        "XF86AudioMute"        = "exec pactl set-sink-mute 0 toggle";
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

  # dunst
  services.dunst = {
    enable = true;
  };

  # sakura
  # https://github.com/rycee/home-manager/issues/871
  xdg.configFile."sakura/sakura.conf".source = "${./config/sakura/sakura.conf}";
}