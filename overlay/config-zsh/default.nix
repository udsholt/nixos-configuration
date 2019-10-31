{ mutate, oh-my-zsh }: 
mutate ./zshrc {
  inherit oh-my-zsh;

  oh_my_zsh_home="${oh-my-zsh}/share/oh-my-zsh";
  oh_my_zsh_theme="amuse";
}
