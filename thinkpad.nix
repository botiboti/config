# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, modulesPath, ... }:

{

  networking.hostName = "thinkpad"; # Define your hostname.

  home-manager.users.botondf = import ./home.nix;

  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/39f685d5-47f3-482f-8204-6863b363144c";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-4ad4a4e4-39f2-4376-a11c-d1006d578eca".device =
    "/dev/disk/by-uuid/4ad4a4e4-39f2-4376-a11c-d1006d578eca";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/254B-FF1D";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/20840964-ee7e-40bb-9175-be7b372d646c"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.opengl.extraPackages = with pkgs; [ rocmPackages.clr.icd ];

  boot.initrd.luks.devices."luks-08e1e089-9738-483d-9bbb-0d16d541f793".device =
    "/dev/disk/by-uuid/08e1e089-9738-483d-9bbb-0d16d541f793";

  # Enable networking
  networking.networkmanager.enable = true;

  users.groups.nix-users.members = [ "botondf" ];
  users.extraGroups.vboxusers.members = [ "botondf" ];

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  services.udev.extraRules = ''
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';
  services.xserver.libinput.touchpad.accelSpeed = "0.8";
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.botondf = {
    isNormalUser = true;
    description = "Botond Ferenczi";
    extraGroups = [
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "dialout"
      "docker"
      "adbusers"
    ];
    packages = with pkgs; [ git tree firefox ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
