# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs.light.enable = true;
  programs.slock.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.sudo.enable = true;

  networking.hostName = "toty"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Bucharest";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #   wget vim
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 2234 ];
  #@@@@@@222 networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = [ pkgs.vaapiIntel ];
  };

  hardware.bumblebee.enable = true;
  hardware.enableRedistributableFirmware = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  services.xserver = {
    enable = true;
    layout = "us";
    windowManager.i3.enable = true;
    displayManager.gdm.enable = true;
    synaptics = {
      enable = true;
      vertTwoFingerScroll = true;
      horizTwoFingerScroll = true;
      palmDetect = true;
      additionalOptions = ''
        Option "VertScrollDelta" "-70"
        Option "HorizScrollDelta" "-70"
      '';
      accelFactor = "0.1";
    };
  };

   fonts = {
     enableFontDir = true;
     fonts = with pkgs; [ corefonts terminus_font terminus_font_ttf ubuntu_font_family carlito hasklig mononoki fira fira-code fira-code-symbols fira-mono source-sans-pro source-serif-pro source-code-pro noto-fonts noto-fonts-cjk noto-fonts-emoji ];
   };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.botiboti = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "dialout" "audio" "video" ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
