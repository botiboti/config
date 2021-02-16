{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fzf
    nixfmt
    transmission-gtk
    networkmanager_dmenu
    tree
    volumeicon
    gcc
    w3m
    tmux
    chromium
    arandr
    docker
    mpv
    libreoffice
    calibre
    elmPackages.elm
    arduino
    xclip
    elmPackages.elm-format
    xdotool
    maim
    nodejs
    pavucontrol
    blender
    rustup
    librecad
    simplescreenrecorder
    keepass
    pciutils
    tmate
    firefox
    htop
    vscode
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
    blueberry
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
    mlton
    service-wrapper
    socat
  ];

  nixpkgs = {
    config = import ./config.nix;
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
