{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "istio-${version}";
  version = "1.4.5";

  src = fetchurl {
    url = "https://github.com/istio/istio/releases/download/${version}/istio-${version}-linux.tar.gz";
    sha256 = "1kw2g8v0pw0iw1rs2zv56dy4mli72n9ih1ywcpwlx6zy5k136zcc";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase= ''
    mkdir $out
    mv * $out
  '';
}