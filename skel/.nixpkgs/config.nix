{
  packageOverrides = pkgs: rec {
    apps = pkgs.buildEnv {
      name = "apps";
      paths = with pkgs; [
        w3m tmux atom chromium git
      ];
    };
  };
}
