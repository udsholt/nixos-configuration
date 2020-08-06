{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    go

    #gcc

    protobuf
    go-protobuf

    grpcurl
    grpcui

    vgo2nix
  ];

  environment.variables = {
    #GOROOT = [ "${pkgs.go_1_13_unstable.out}/share/go" ];
    GO111MODULE= "on";
  };
}

