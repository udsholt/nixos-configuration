{ mutate, zsh, zsh-prezto, direnv }: {
  zshrc = mutate ./zshrc {
    inherit direnv;
    zsh_presto="${zsh-prezto}";
  };

  zpreztorc = ./zpreztorc;
}

