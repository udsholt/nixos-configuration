# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports = [
    ../role/base.nix
    ../role/users.nix
    ../role/desktop.nix
    ../role/docker.nix
    ../role/golang.nix
    ../role/kubernetes.nix
    ../role/terraform.nix
    ../role/node.nix
  ];

  # NixOS release with version
  system.stateVersion = "19.09";

  # Hello, i'm running in virtualbox
  virtualisation.virtualbox.guest.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "barnacle";
  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Set hardware config
  boot.initrd.availableKernelModules = [ "ohci_pci" "ahci" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/b1405dfd-b674-4776-bd5a-4ff8acc46f4d";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/4CA0-5506";
      fsType = "vfat";
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 4;
}

