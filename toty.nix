{ pkgs, lib, config, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  networking.hostName = "toty";
  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-*" ];
      externalInterface = "wlp8s0";
    };
  };

  home-manager.users.botiboti = import ./home.nix;

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "udev.log_priority=3" ];
    # extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/4937f733-3686-4e34-9c21-00cde4efdae1";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/D081-5EDD";
      fsType = "vfat";
    };
  };

  environment.systemPackages = [ nvidia-offload ];
  hardware = {
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      prime = {
        offload.enable = false;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
  };

  # DO NOT CHANGE
  system.stateVersion = "18.09";
}
