{ pkgs, lib, config, ... }:
let
  # unstable = import <unstable> {
  # config.allowUnfree = true;
  # };

  # nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
  #     export __NV_PRIME_RENDER_OFFLOAD=1
  #     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
  #     export __GLX_VENDOR_LIBRARY_NAME=nvidia
  #     export __VK_LAYER_NV_optimus=NVIDIA_only
  #     exec -a "$0" "$@"
  # '';
in
  {
    imports = [
      <home-manager/nixos>
    ];
    home-manager.users.botiboti = import ./home.nix;

    boot = {
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
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

      swapDevices = [ ];

      nix.maxJobs = lib.mkDefault 8;
      powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

      nixpkgs.config = {
        allowUnfree = true;
      };

      networking = {
        firewall = {
          enable = true;
        };
        hostName = "toty";
        nat = {
          enable = true;
          internalInterfaces = [ "ve-*" ];
          externalInterface = "wlp8s0";
        };
        networkmanager = {
          enable = true;
          unmanaged = [ "interface-name:ve-*" ];
        };
        # wireguard.interfaces.wg0 = {
        #   ips = [ "10.10.10.42/24" ];
        #   privateKeyFile = "/root/secret/wireguard";
        #   peers = [{
        #     publicKey = "TpzpokNmwEtlccYx0U+yKy5+xUeFp9RisO7FnnwZJlA=";
        #     allowedIPs = [ "10.10.10.0/24" ];
        #     endpoint = "calculon.eket.su:51820";
        #     persistentKeepalive = 25;
        #   }];
        # };
      };

      time.timeZone = "Europe/Bucharest";

      hardware = {
        opengl = {
          enable = true;
          driSupport32Bit = true;
          extraPackages = [ pkgs.vaapiIntel ];
        };

        enableRedistributableFirmware = true;
        bluetooth = {
          enable = true;
          powerOnBoot = false;
        };

        pulseaudio = {
          enable = true;
          support32Bit = true;
          extraModules = [ pkgs.pulseaudio-modules-bt ];
          package = pkgs.pulseaudioFull;
        };

        # nvidia.prime = {
        #  offload.enable = false;
        #  nvidiaBusId = "PCI:1:0:0";
        #  intelBusId = "PCI:0:2:0";
        # };
      };

      virtualisation.docker = {
        enable = true;
        enableNvidia = false;
      };

      sound.enable = true;

      services.xserver = {
        enable = true;
        videoDrivers = [ "intel" ];
        layout = "us";
        windowManager = {
          i3.enable = true;
          i3.extraPackages = with pkgs;
          [
            i3status
            dmenu
          ];
        };
        displayManager = {
          sddm.enable = true;
        };
        libinput = {
          enable = true;
        };
      };

      services.openssh = {
        enable = true;
        passwordAuthentication = false;
      };

      services.blueman.enable = true;
      services.teamviewer.enable = true;

      services.picom.enable = true;
      services.picom.vSync = true;

      services.xmr-stak.cudaSupport = true;

      services.xserver.wacom.enable = true;

      services.physlock = {
        enable = true;
        lockOn.suspend = true;
        lockMessage = "Hello. Do not power me off please.";
      };

#      services.tor = {
#        enable=true;
#        client.enable=true;
#      };

#      services.privoxy = {
#        enable = true;
#        enableTor = true;
#      };

      fonts = {
        enableDefaultFonts = true;
        fontconfig = {
          enable = true;
          cache32Bit = true;
          defaultFonts = {
            monospace = [ "Fira Code Light" "DejaVu Sans Mono" ];
            sansSerif = [ "Fira Sans" "DejaVu Sans" ];
            serif = [ "DejaVu Serif" ];
          };
        };
        fonts = with pkgs; [
          carlito
          corefonts
          fira
          fira-code
          fira-code-symbols
          fira-mono
          hasklig
          mononoki
          noto-fonts
          noto-fonts-cjk
          noto-fonts-emoji
          source-code-pro
          source-sans-pro
          source-serif-pro
          terminus_font
          terminus_font_ttf
          ubuntu_font_family
        ];
      };

      users.groups.nix-users.members = [ "botiboti" ];

      users.users = {
        botiboti = {
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
        };
        ssdd = {
          isNormalUser = true;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZOC3FgP/8TUK62obAW/uDENhdXkLGAjickSF53zncg ssdd@eki"
          ];
        };
      };

      environment = {
        variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };

      programs = {
        adb.enable = true;
        light.enable = true;
#    i3lock.enable = true;
  };

  # DO NOT CHANGE
  system.stateVersion = "18.09";
}
