{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    fzf
    nixfmt
    transmission-gtk
    soundux
    networkmanager_dmenu
    rofi
    volumeicon
    maim
    tmux
    arandr
    mpv
    libreoffice
    calibre
    elmPackages.elm
    arduino
    xclip
    elmPackages.elm-format
    xdotool
    pavucontrol
    librecad
    simplescreenrecorder
    keepass
    pciutils
    firefox
    spotify
    todo
    jrnl
    htop
    opensc
    vscodium
    discord
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
    skypeforlinux
    lsscsi
    service-wrapper
    socat
    tdesktop
    texlive.combined.scheme-full
    dconf
    lxappearance
    # gnome3.adwaita-icon-theme
    steam
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
      initExtra = ''
        source ~/.nix-profile/share/git/contrib/completion/git-prompt.sh
        export PS1='\n\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w]$(__git_ps1 "(%s) ")Ξ \[\033[0m\]'
      '';
      bashrcExtra = lib.mkBefore "source ~/config/.custom_commands.sh";
    };

    git = {
      enable = true;
      userEmail = "botondferenczi98@gmail.com";
      userName = "Botond Ferenczi";
    };
  };

  home.stateVersion = "22.05";
}
