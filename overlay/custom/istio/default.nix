{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "istio-${version}";
  version = "1.4.4";

  src = fetchurl {
    url = "https://github.com/istio/istio/releases/download/${version}/istio-${version}-linux.tar.gz";
    sha256 = "09wwaz3n70bagcw79dmqcp9020rylvk38k6pzcj2qpkciqh6alqh";
  };

  phases = [ "unpackPhase" "installPhase" ];

  installPhase= ''
    mkdir $out
    mv * $out
  '';
}