{ stdenvNoCC }:

stdenvNoCC.mkDerivation rec {
  name = "utilties";
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp ${./bin/setup-keys} $out/bin/setup-keys
    chmod +x $out/bin/setup-keys
    patchShebangs $out/bin/setup-keys
  '';
}
