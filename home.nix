{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fzf
    nixfmt
    transmission-gtk
    networkmanager_dmenu
    rofi
    tree
    pnmixer
    gcc
    w3m
    tmux
    chromium
    arandr
    docker
    docker-compose
    mpv
    libreoffice
    calibre
    elmPackages.elm
    arduino
    xclip
    elmPackages.elm-format
    xdotool
    nodejs
    pavucontrol
    blender
    rustup
    librecad
    simplescreenrecorder
    keepass
    pciutils
    firefox
    htop
    vscodium
    discord
    teams
    kodelife
    binutils
    glxinfo
    linuxHeaders
    nmap
    zoom-us
    slack
    postgresql
    yarn
    xorg.xinit
    wine
    usbutils
    unzip
    steam
    teamviewer
    terraform
    skypeforlinux
    lsscsi
    service-wrapper
    socat
    tdesktop
    dconf
    lxappearance

  ];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (self: super: {
        neovim = super.neovim.override {
          viAlias = true;
          vimAlias = true;
        };
      })
    ];
  };

  imports = [ ./vim.nix ];
 
  gtk = {
        enable = true;
        font.name = "source-code-pro";
        theme = {
          name = "Juno";
          package = pkgs.juno-theme;
        };
      };

  programs = {

    bash = {
      enable = true;
      bashrcExtra = lib.mkBefore "source ~/config/.custom_commands.sh";
    };

    git = {
      enable = true;
      userEmail = "botondferenczi98@gmail.com";
      userName = "Botond Ferenczi";
    };
  };
}