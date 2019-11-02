{ mutate, zsh, zsh-prezto }: {
  zshrc = mutate ./zshrc {
    zsh_presto="${zsh-prezto}";
  };

  zpreztorc = ./zpreztorc;
}

