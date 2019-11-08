{secrets}: self: super:
{
  inherit secrets;

  mutate = self.callPackage ./mutate { };

  oh-my-zsh-custom = self.callPackage ./oh-my-zsh-custom { };
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

  vscodium  = super.callPackage ./vscode/vscodium.nix {};

  alacritty = super.alacritty.overrideAttrs (x: {
    postPatch = ''
      substituteInPlace alacritty_terminal/src/config/mouse.rs \
        --replace xdg-open ${self.xdg_utils}/bin/xdg-open
    '';
  });
}
