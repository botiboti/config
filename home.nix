{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
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
    vim
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
  ];

  nixpkgs.config.allowUnfree = true;

  programs = {

    bash = {
      enable = true;
      bashrcExtra = lib.mkBefore ''source ~/config/.custom_commands.sh'';
    };

    git = {
      enable = true;
      userEmail = "botondferenczi98@gmail.com";
      userName = "Botond Ferenczi";
    };
  };
}
