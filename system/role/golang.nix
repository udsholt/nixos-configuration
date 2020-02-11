{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    go_1_13_unstable

    #gcc

    protobuf
    go-protobuf

    grpcurl
    grpcui
  ];

  environment.variables = {
    GOROOT = [ "${pkgs.go_1_13_unstable.out}/share/go" ];
    GO111MODULE= "on";
  };
}

