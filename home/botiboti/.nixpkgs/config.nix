{
  allowUnfree = true;

  chromium = {
    # enablePepperFlash = true;
    # enablePepperPDF = true;
  };

  packageOverrides = pkgs: rec {
    apps = pkgs.buildEnv {
      name = "apps";
      paths = with pkgs; [
        transmission-gtk networkmanager_dmenu
        tree volumeicon gcc w3m tmux atom chromium git
        arandr mpv libreoffice calibre elmPackages.elm
        arduino xclip vscode discord elmPackages.elm-format
        xdotool maim unzip kodelife nodejs pavucontrol
        blender teamviewer
      ];
    };
  };
}
