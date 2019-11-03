{ config, pkgs, lib, ... }:

{
    environment.systemPackages = with pkgs; [
        go
        gcc
    ];

    environment.variables = {
        GO111MODULE= "on";
        #GOFLAGS="-mod=vendor";
    };
}

