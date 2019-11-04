{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    go

    gcc

    protobuf
    go-protobuf
  ];

  environment.variables = {
    GO111MODULE= "on";
  };
}

