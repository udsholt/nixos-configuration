{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    go_1_13

    #gcc

    protobuf
    go-protobuf

    grpcurl
    grpcui

    vgo2nix
  ];

  environment.variables = {
    GOROOT = [ "${pkgs.go_1_13.out}/share/go" ];
    GO111MODULE= "on";
  };
}

