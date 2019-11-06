{ mutate, oh-my-zsh, direnv, stdenvNoCC }: mutate ./zshrc {
  inherit oh-my-zsh;
  inherit direnv;

  oh_my_zsh_home="${oh-my-zsh}/share/oh-my-zsh";
  oh_my_zsh_custom = stdenvNoCC.mkDerivation {
    name = "oh-my-zsh-custom";
    phases = [ "installPhase" ];
    installPhase = ''
        mkdir -p $out/plugins
        mkdir -p $out/themes

        cp ${./themes/red.zsh-theme} $out/themes/red.zsh-theme
    '';
  };

  oh_my_zsh_theme="red";
}
