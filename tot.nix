{ config, lib, pkgs, modulesPath, ... }: {
  networking.hostName = "tot";

  home-manager.users.boti = import ./home.nix;

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.blacklistedKernelModules =
    [ "psmouse" "intel_hid" "ucsi_acpi" "typec_ucsi" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/cce2f748-542f-462b-a17f-6db260d7f132";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/83FB-190D";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/ff388478-38e1-48c6-817e-8f26a4d9572e"; }];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.luks.devices = {
    cryptroot = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  users.groups.nix-users.members = [ "boti" ];
  users.extraGroups.vboxusers.members = [ "boti" ];

  services.xserver.libinput.touchpad.accelSpeed = "0.8";
  services.tlp.enable = true;

  environment.systemPackages =
    [ pkgs.libva-utils pkgs.xinput_calibrator pkgs.onboard ];

  environment.variables = {
    VDPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };

  environment.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };

  users.users = {
    boti = {
      isNormalUser = true;
      uid = 1000;
      extraGroups = [
        "wheel"
        "adbusers"
        "networkmanager"
        "dialout"
        "audio"
        "video"
        "docker"
      ];
      packages = with pkgs; [ firefox tree git ];
    };
  };

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
