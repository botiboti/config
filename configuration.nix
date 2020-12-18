{ config, pkgs, lib, ... }:
{

  imports = [ <home-manager/nixos> ];
  home-manager.users.botiboti = import ./home.nix;

  boot = {  
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;   
    };    
    initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sdhci_pci" ];
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
 
   nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };

  networking = {
    hostName = "toty";
    networkmanager.enable = true;
    # firewall.allowedTCPPorts = [ 2234 ];
    wireguard.interfaces.wg0 = {
      ips = [ "10.10.10.42/16" ];
      privateKeyFile = "/root/secret/wireguard";
      peers = [
        {
          publicKey = "TpzpokNmwEtlccYx0U+yKy5+xUeFp9RisO7FnnwZJlA=";
          allowedIPs = [ "10.10.0.0/16" ];
          endpoint = "calculon.eket.su:51820";
          persistentKeepalive = 25;
        }
      ];
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
    bluetooth.enable = true;
  
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
  };
  
  sound.enable = true;
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "nv" ];
    layout = "us";
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      horizTwoFingerScroll = true;
      palmDetect = true;
      additionalOptions = ''
        Option "VertScrollDelta" "-70"
        Option "HorizScrollDelta" "-70"
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
      extraGroups = [ "wheel" "adbusers" "networkmanager" "dialout" "audio" "video" "sway"];
    };
    ssdd = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFZOC3FgP/8TUK62obAW/uDENhdXkLGAjickSF53zncg ssdd@eki" ];
    };
  };
  
  programs = {
    adb.enable = true;
    light.enable = true;
    slock.enable = true;
  };
 
  # DO NOT CHANGE
  system.stateVersion = "18.09";
}
