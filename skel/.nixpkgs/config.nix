{
  allowUnfree = true;

  chromium = {
    enablePepperFlash = true;
    enablePepperPDF = true;
  };

  packageOverrides = pkgs: rec {
    apps = pkgs.buildEnv {
      name = "apps";
      paths = with pkgs; [
        binutils networkmanager_dmenu volumeicon gcc w3m tmux atom chromium git
      ];
    };
  };
}
