{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    neovim
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
    nodejs
    lsscsi
    mlton
    service-wrapper
    socat
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {

    bash = {
      enable = true;
      bashrcExtra = lib.mkBefore "source ~/config/.custom_commands.sh";
    };

    neovim = { enable = true; };

    git = {
      enable = true;
      userEmail = "botondferenczi98@gmail.com";
      userName = "Botond Ferenczi";
    };
  };
}
