{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fzf
    nixfmt
    transmission-gtk
    networkmanager_dmenu
    rofi
    volumeicon
    maim
    gcc
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
    nodejs-18_x
    pavucontrol
    rustup
    librecad
    simplescreenrecorder
    keepass
    pciutils
    firefox
    htop
    opensc
    vscodium
    discord
    teams
    binutils
    glxinfo
    linuxHeaders
    nmap
    zoom-us
    slack
    postgresql
    yarn
    root
    xorg.xinit
    usbutils
    nixpkgs-fmt
    unzip
    terraform
    skypeforlinux
    lsscsi
    service-wrapper
    socat
    tdesktop
    texlive.combined.scheme-full
    dconf
    lxappearance
    gnome3.adwaita-icon-theme
    monero-gui
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
