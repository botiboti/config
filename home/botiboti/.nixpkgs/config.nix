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
        arduino xclip vscode elmPackages.elm-format
        xdotool maim kodelife nodejs pavucontrol
        blender rustup zoom-us discord steam librecad
        simplescreenrecorder keepass teams pciutils vim
      ];
    };
  };
}
