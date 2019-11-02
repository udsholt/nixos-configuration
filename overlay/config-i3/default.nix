{ mutate, xeventbind, feh }: {
  config = mutate ./config {
    inherit xeventbind;

    setup = mutate ./setup.sh {
      inherit feh;
    };
  };
}
