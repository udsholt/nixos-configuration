{secrets}: self: super:
{
  inherit secrets;

  mutate = self.callPackage ./mutate { };

  config-i3        = self.callPackage ./config-i3 { };
  config-git       = self.callPackage ./config-git { inherit secrets; };
  config-rofi      = self.callPackage ./config-rofi { };
  config-sakura    = self.callPackage ./config-sakura { };
  config-prezto    = self.callPackage ./config-prezto { };
  config-codium    = self.callPackage ./config-codium { };
  config-alacritty = self.callPackage ./config-alacritty { };

  utilties = self.callPackage ./utilties { };

  cqlsh = super.callPackage ./package/cqlsh {};

  sqlworkbench = super.callPackage ./package/sqlworkbench {};

  xeventbind = super.callPackage ./xeventbind {
    libX11 = super.xorg.libX11;
  };

  sakura = super.callPackage ./sakura {
    gtk = super.gnome2.gtk;
    vte = super.gnome2.vte;
  };

  polybar = super.polybar.override {
    i3GapsSupport = true;
  };

  alacritty = super.alacritty.overrideAttrs (x: {
    postPatch = ''
      substituteInPlace alacritty_terminal/src/config/mouse.rs \
        --replace xdg-open ${self.xdg_utils}/bin/xdg-open
    '';
  });
}
