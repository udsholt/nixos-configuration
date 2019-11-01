{ secrets }: self: super:
{
  mutate = self.callPackage ./mutate { };

  config-i3        = self.callPackage ./config-i3 { };
  config-zsh       = self.callPackage ./config-zsh { };
  config-git       = self.callPackage ./config-git { inherit secrets; };
  config-alacritty = self.callPackage ./config-alacritty { };

  alacritty = super.alacritty.overrideAttrs (x: {
    postPatch = ''
      substituteInPlace alacritty_terminal/src/config/mouse.rs \
        --replace xdg-open ${self.xdg_utils}/bin/xdg-open
    '';
  });
}
