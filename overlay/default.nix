{ secrets }: self: super:
{
  mutate = self.callPackage ./mutate { };

  config-i3        = self.callPackage ./config-i3 { };
  config-zsh       = self.callPackage ./config-zsh { };
  config-git       = self.callPackage ./config-git { inherit secrets; };
  config-alacritty = self.callPackage ./config-alacritty { };

  xeventbind = super.callPackage ./xeventbind {
    libX11 = super.xorg.libX11;
  };

  sakura = super.callPackage ./sakura {
    gtk = super.gnome2.gtk;
    vte = super.gnome2.vte;
  };

  alacritty = super.alacritty.overrideAttrs (x: {
    postPatch = ''
      substituteInPlace alacritty_terminal/src/config/mouse.rs \
        --replace xdg-open ${self.xdg_utils}/bin/xdg-open
    '';
  });
}
