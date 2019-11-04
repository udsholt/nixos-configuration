# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ../role/desktop.nix
    ../role/golang.nix
  ];

  # NixOS release with version
  system.stateVersion = "19.09";

  # Network
  networking.hostName = "toaster";
  networking.hostId = "8ce3d089";

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # More bootstuff
  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Danish layout
  i18n.consoleFont   = "lat9w-16";
  i18n.consoleKeyMap = "dk";
  i18n.defaultLocale = "en_US.UTF-8";

  # Danish xserver
  services.xserver.layout = "dk";

  # Enable synaptics touchpad
  services.xserver.synaptics = {
    enable = true;
    tapButtons = false;
    vertEdgeScroll = true;
    twoFingerScroll = false;
  };

  # Pulse audio
  hardware.pulseaudio.enable = true;

  # Network manager
  networking.networkmanager.enable = true;
  services.dbus.enable = true;

  # Additional packages
  environment.systemPackages = with pkgs; [
    pavucontrol
    networkmanagerapplet
  ];

  # Filesystem layout
  fileSystems = [{
    mountPoint = "/";
    device = "/dev/disk/by-uuid/6aaf3077-261a-44b8-9723-b35862fd784b";
    fsType = "ext4";
  }{
    mountPoint = "/home";
    device = "/dev/disk/by-uuid/098b5c2a-2312-4c0d-8fc3-720fbc48ed99";
    fsType = "ext4";
  }];

  # Swapfile
  swapDevices = [{
    device = "/var/swapfile";
    size = 4096;
  }];

  nix.maxJobs = lib.mkDefault 2;
}

