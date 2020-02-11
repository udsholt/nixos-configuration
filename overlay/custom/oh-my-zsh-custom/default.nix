{ stdenvNoCC }: stdenvNoCC.mkDerivation {
  name = "oh-my-zsh-custom";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/plugins
    mkdir -p $out/themes

    cp ${./themes/red.zsh-theme} $out/themes/red.zsh-theme
  '';
}