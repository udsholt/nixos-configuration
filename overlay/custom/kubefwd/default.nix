{ buildGoPackage, fetchFromGitHub }:
buildGoPackage rec {
  name = "kubefwd-${version}";
  version = "1.11.0";
  goPackagePath = "github.com/txn2/kubefwd";
  src = fetchFromGitHub {
    owner  = "txn2";
    repo   = "kubefwd";
    rev    = "${version}";
    sha256 = "1wac0znda2s0qrcqgl4w5l8hklqs16qy9fjdhclp3ch194azyycr";
  };

  goDeps = ./deps.nix;
}