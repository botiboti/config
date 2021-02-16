{ pkgs, lib, ... }: {

  imports = [ <home-manager/nixos> ];
  home-manager.users.botiboti = import ./home.nix;

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules =
      [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
    kernelModules = [ "kvm-intel" ];
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
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  nixpkgs = { 
    config = import ./config.nix; 
 };

  networking = {
    firewall.allowedTCPPorts = [ 4713 6000 ];
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
    wireguard.interfaces.wg0 = {
      ips = [ "10.10.10.42/16" ];
      privateKeyFile = "/root/secret/wireguard";
      peers = [{
        publicKey = "TpzpokNmwEtlccYx0U+yKy5+xUeFp9RisO7FnnwZJlA=";
        allowedIPs = [ "10.10.0.0/16" ];
        endpoint = "calculon.eket.su:51820";
        persistentKeepalive = 25;
      }];
    };
  };

  time.timeZone = "Europe/Lisbon";

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = [ pkgs.vaapiIntel ];
    };

    # hnvidia.prime = {
    #   sync.enable = true;
    #   nvidiaBusId = "PCI:1:0:0";
    #   intelBusId = "PCI:0:2:0";
    # };

    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      /* config = General {
           Enable = "Source,Sink,Media,Socket";
         };
      */
    };

    pulseaudio = {
      enable = true;
      systemWide = true;
      support32Bit = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
      tcp = {
        enable = true;
        anonymousClients = {
          allowedIpRanges = [ "127.0.0.1" "192.168.7.0/24" ];
        };
      };
    };
  };

  virtualisation.docker.enable = true;

  sound.enable = true;

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "nv" ];
    layout = "us";
    windowManager = {
      i3.enable = true;
    };
    displayManager = {
      lightdm = { enable = true; };
    };
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      horizTwoFingerScroll = true;
      additionalOptions = ''
                Option "VertScrollDelta" "-70"
                Option "HorizScrollDelta" "-70"
                Option "PalmDetection" "True"
                '';
      accelFactor = "0.09";
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
  };

  services.blueman.enable = true;
  services.teamviewer.enable = true;

  services.tor = {
    enable = true;
    client.enable = true;
  };

  fonts = {
    enableFontDir = true;
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
        "sway"
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

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs = {
    adb.enable = true;
    light.enable = true;
    slock.enable = true;
  };

  # DO NOT CHANGE
  system.stateVersion = "18.09";
}
