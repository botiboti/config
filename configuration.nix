{ pkgs, lib, config, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nix = { settings.experimental-features = [ "nix-command" "flakes" ]; };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  nixpkgs.config = { allowUnfree = true; };

  networking = {
    firewall = { enable = true; };
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
    };
  };

  time.timeZone = "Europe/Lisbon";

  systemd.services.NetworkManager-wait-online.enable = false;

  hardware = {
    opengl = {
      enable = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };

  virtualisation.virtualbox.host.enable = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" ];
    layout = "us, hu";
    xkbModel = "pc104";
    xkbOptions = "grp:switch";
    windowManager = {
      i3.enable = true;
      i3.extraPackages = with pkgs; [ i3status dmenu ];
    };
    displayManager = { sddm.enable = true; };
    deviceSection = ''
      Option "TearFree" "true"
    '';
    libinput = {
      enable = true;
      # disabling mouse acceleration
      mouse = { accelProfile = "flat"; };

      # disabling touchpad acceleration
      touchpad = { accelProfile = "flat"; };
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.blueman.enable = true;

  services.picom.enable = true;
  services.picom.vSync = true;

  services.physlock = {
    enable = true;
    lockOn.suspend = true;
  };

  systemd.services.physlock.serviceConfig.ExecStart = lib.mkForce ''
    ${pkgs.physlock}/bin/physlock -dsm -p "Hello. Do not power me off please."'';

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

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    systemPackages = [ pkgs.micro pkgs.bat ];
  };

  programs = {
    adb.enable = true;
    light.enable = true;
    # bash.promptInit = ''PS1="\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]Ξ \[\033[0m\]"'';
  };

  system.activationScripts.diff = ''
    if [ -e /run/current-system ]; then
            ${pkgs.nvd}/bin/nvd --nix-bin-dir ${pkgs.nix}/bin diff /run/current-system/ "$systemConfig"
    fi
  '';
}
