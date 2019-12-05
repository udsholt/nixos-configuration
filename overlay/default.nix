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

  kubefwd = super.callPackage ./kubefwd {};

  sakura = super.callPackage ./sakura {
    gtk = super.gnome2.gtk;
    vte = super.gnome2.vte;
  };

  polybar = super.polybar.override {
    i3GapsSupport = true;
  };

  go_1_13_plain = super.callPackage ./go/1.13.nix {
    Security = "";
    Foundation = "";
  };

  go_1_13 = self.go_1_13_plain.overrideAttrs(oldAttrs: {
    checkPhase = '''';
  });

  vscodium  = super.callPackage ./vscode/vscodium.nix {};

  vscode-with-extensions = super.vscode-with-extensions.override {
    vscodeExtensions = with self.vscode-extensions; [
      ms-vscode.cpptools
      bbenoist.Nix
    ] ++ self.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "trailing-spaces";
        publisher = "shardulm94";
        version = "0.3.1";
        sha256 = "0h30zmg5rq7cv7kjdr5yzqkkc1bs20d72yz9rjqag32gwf46s8b8";
      }
      {
        name = "vscode-direnv";
        publisher = "rubymaniac";
        version = "0.0.2";
        sha256 = "1gml41bc77qlydnvk1rkaiv95rwprzqgj895kxllqy4ps8ly6nsd";
      }
    ];
  };

  alacritty = super.alacritty.overrideAttrs (x: {
    postPatch = ''
      substituteInPlace alacritty_terminal/src/config/mouse.rs \
        --replace xdg-open ${self.xdg_utils}/bin/xdg-open
    '';
  });
}
