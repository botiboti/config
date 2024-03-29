{ pkgs, lib, config, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  nix = { settings.experimental-features = [ "nix-command" "flakes" ]; };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

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
    };

    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    pulseaudio = {
      enable = true;
      support32Bit = true;
      package = pkgs.pulseaudioFull;
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  services.xserver = {
    enable = true;
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
      mouse = { accelProfile = "adaptive"; };

      # disabling touchpad acceleration
      touchpad = { accelProfile = "flat"; };
    };
  };

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  services.blueman.enable = true;

  services.physlock = {
    enable = true;
    lockOn.suspend = true;
    lockMessage = "Hello. Do not power me off please.";
  };

  users.defaultUserShell = pkgs.zsh;

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      cache32Bit = true;
      defaultFonts = {
        monospace = [ "Fira Code Light" "DejaVu Sans Mono" ];
        sansSerif = [ "Fira Sans" "DejaVu Sans" ];
        serif = [ "DejaVu Serif" ];
      };
    };
    packages = with pkgs; [
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
    zsh.enable = true;
  };

  system.activationScripts.diff = ''
    if [ -e /run/current-system ]; then
            ${pkgs.nvd}/bin/nvd --nix-bin-dir ${pkgs.nix}/bin diff /run/current-system/ "$systemConfig"
    fi
  '';
}
