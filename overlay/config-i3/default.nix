{ mutate, sakura, rofi, xeventbind, feh }: {
  config = mutate ./config {
    inherit rofi;
    inherit sakura;
    inherit xeventbind;

    setup = mutate ./setup.sh {
      inherit feh;
    };
  };
}
