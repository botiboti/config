{
  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    # enablePepperPDF = true;
  };

  packageOverrides = pkgs: rec {
    apps = pkgs.buildEnv {
      name = "apps";
      paths = with pkgs; [
        binutils transmission-gtk networkmanager_dmenu
        tree volumeicon gcc w3m tmux atom chromium git
        arandr mpv libreoffice calibre
      ];
    };
  };
}
