{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    go

    gcc

    protobuf
    go-protobuf

    grpcurl
    grpcui

    vgo2nix
  ];

  environment.variables = {
    GO111MODULE= "on";
  };
}

