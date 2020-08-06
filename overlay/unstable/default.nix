# This overlay allows importing specific packages from unstable
self: super:
let
  unstable = import <nixos-unstable> {};
in
{
  #go_1_13_unstable = unstable.go_1_13;
  terraform_0_12_unstable = unstable.terraform_0_12;
  vscodium_unstable = unstable.vscodium;
  act_unstable = unstable.act;
}
