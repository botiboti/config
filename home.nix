{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    xlockmore
    fzf
    nixfmt
    transmission-gtk
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
    simplescreenrecorder
    keepass
    pciutils
    firefox
    todo
    htop
    vscodium
    discord
    binutils
    autorandr
    glxinfo
    linuxHeaders
    nmap
    zoom-us
    postgresql
    yarn
    xorg.xinit
    usbutils
    nixpkgs-fmt
    unzip
    lsscsi
    service-wrapper
    socat
    dconf
    lxappearance
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

  gtk = {
    enable = true;
    font.name = "source-code-pro";
    theme = {
      name = "Juno";
      package = pkgs.juno-theme;
    };
  };

  xresources.extraConfig = builtins.readFile ./xresources/.Xresources;

  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "thefuck" "z" ];
        theme = "takashiyoshida";
      };
      plugins = [{
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }];
    };

    thefuck.enable = true;

    neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      plugins = with pkgs.vimPlugins; [
        incsearch-vim
        nvim-treesitter
        yankring
        vim-airline
        vim-go
        elm-vim
        i3config-vim
        fzf-vim
        neocomplete
        vim-autoformat
        vim-nix
        tokyonight-nvim
        nerdtree
        {
          plugin = vim-startify;
          config = "let g:startify_change_to_vcs_root = 0";
        }
      ];
      extraConfig = ''
        let mapleader = ","
        let maplocalleader = "*"
        let NERDTreeShowHidden=1
        let g:loaded_python_provider = 0

        autocmd FocusGained * silent! checktime

        set ignorecase
        set noswapfile
        set autoread
        set modifiable
        set number
        set incsearch
        set filetype=i3config
        set softtabstop=4
        set shiftwidth=4
        set background=dark

        :au CursorHold * :checktime
        :au FocusLost * :Autoformat
        :au FocusLost * :wa

        nmap <C-n> :NERDTreeToggle<CR>
        map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

        colorscheme tokyonight-night

        filetype plugin on
        filetype indent on
      '';
    };

    git = {
      enable = true;
      userEmail = "botondferenczi98@gmail.com";
      userName = "Botond Ferenczi";
    };

    i3status.enable = true;

    i3status.general = {
      colors = true;
      interval = 1;
      color_good = "#ffffff";
      color_degraded = "#888888";
      color_bad = "#eef524";
    };

    i3status.modules = lib.mkForce {
      "wireless _first_" = {
        position = 2;
        settings = {
          format_up = " %quality %ip %essid ";
          format_down = " W: down ";
        };
      };

      "ethernet _first_" = {
        position = 4;
        settings = {
          # if you use %speed, i3status requires root privileges
          #format_up = "E %ip (%speed)"
          #format_up = " e %ip "
          format_down = " E down ";
        };
      };

      "battery 0" = {
        position = 1;
        settings = {
          format = " %status %percentage %remaining ";
          status_chr = "⚡ CHR";
          status_bat = "🔋 BAT";
          status_full = "☻ FULL";
          status_unk = "? UNK";
        };
      };

      "cpu_usage" = {
        position = 5;
        settings = { format = " %usage "; };
      };

      "load" = {
        position = 6;
        settings = { format = " %1min "; };
      };

      "disk /" = {
        position = 3;
        settings = { format = " %free "; };
      };

      "tztime pt" = {
        position = 7;
        settings = {
          timezone = "Europe/Lisbon";
          format = "%A, %d.%m.%Y %H:%M:%S";
        };
      };

    };
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;

    name = "Vanilla-DMZ-AA";
    package = pkgs.vanilla-dmz;
    size = 20;
  };

  xsession.windowManager.i3 = let modifier = "Mod4";
  in {
    enable = true;
    config = {
      modifier = "Mod4";
      keybindings = {
        "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 2 -u";
        "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 2 -u";
      };
      bars = [{
        statusCommand = "i3status";
        mode = "hide";
        colors = { background = "#006666"; };
      }];
    };
    extraConfig = ''
      # This file has been auto-generated by i3-config-wizard(1).
      # It will not be overwritten, so edit it as you like.
      #
      # Should you change your keyboard layout some time, delete
      # this file and re-run i3-config-wizard(1).
      #

        exec "volumeicon"
        exec_always --no-startup-id "xsetroot -solid '#0D3B66'"

      # Moved to config, under xserver

      # exec "setxkbmap -layout us,hu"
      # exec "setxkbmap -option 'grp:switch'"
        exec --no-startup-id "setxkbmap -layout us,hu -option 'grp:switch'"

        bindsym XF86MonBrightnessUp exec light -A 5
        bindsym XF86MonBrightnessDown exec light -U 5

      # i3 config file (v4)
      #
      # Please see https://i3wm.org/docs/userguide.html for a complete reference!

        set $mod Mod4

      # Font for window titles. Will also be used by the bar unless a different font
      # is used in the bar {} block below.
        font pango:source-code-pro 9

      # This font is widely installed, provides lots of unicode glyphs, right-to-left
      # text rendering and scalability on retina/hidpi displays (thanks to pango).
      #font pango:DejaVu Sans Mono 8

      # Before i3 v4.8, we used to recommend this one as the default:
      # font 3t, it doesn’t scale on retina/hidpi displays.

      # Use Mouse+$mod to drag floating windows to their wanted position
        floating_modifier $mod

      # start a terminal
      # bindsym $mod+Return exec i3-sensible-terminal
        bindsym $mod+Return exec "xterm"

      # screenshot and save it to the clipboard
        bindsym --release $mod+s exec --no-startup-id "maim -s | xclip -selection clipboard -t image/png"

      # screenshot active window and paste to the clipboard
        bindsym --release $mod+Shift+s exec --no-startup-id "maim -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png"

      # kill focused window
        bindsym $mod+Shift+q kill

      # start rofi (a program launcher)
        bindsym $mod+d exec exec rofi -show drun -theme Monokai
      # start rofi window mode
        bindsym $mod+Shift+d exec rofi -show window -theme Monokai
      # start rofi in drun mode
        bindsym $mod+Ctrl+Shift+d exec rofi -show run -theme Monokai
      # There also is the (new) i3-dmenu-desktop which only displays applications
      # shipping a .desktop file. It is a wrapper around dmenu, so you need that
      # installed.
      # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

      # change focus
        bindsym $mod+h focus left
        bindsym $mod+j focus down
        bindsym $mod+k focus up
        bindsym $mod+l focus right

      # alternatively, you can use the cursor keys:
        bindsym $mod+Left focus left
        bindsym $mod+Down focus down
        bindsym $mod+Up focus up
        bindsym $mod+Right focus right

      # change profile for Jabra headset
        bindsym --release $mod+b exec "pactl set-card-profile bluez_card.70_BF_92_1A_CD_BA headset_head_unit && pacmd set-default-sink bluez_sink.70_BF_92_1A_CD_BA.headset_head_unit"
        bindsym --release $mod+Shift+b exec "pactl set-card-profile bluez_card.70_BF_92_1A_CD_BA a2dp_sink_aac && pacmd set-default-sink bluez_sink.70_BF_92_1A_CD_BA.a2dp_sink"

      # move focused window
        bindsym $mod+Shift+h move left
        bindsym $mod+Shift+j move down
        bindsym $mod+Shift+k move up
        bindsym $mod+Shift+l move right

      # alternatively, you can use the cursor keys:
        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Down move down
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Right move right

      # split in horizontal orientation
        bindsym $mod+Ctrl+h split h

      # split in vertical orientation
        bindsym $mod+Ctrl+v split v

      # enter fullscreen mode for the focused container
        bindsym $mod+f fullscreen toggle

      # change container layout (stacked, tabbed, toggle split)
        bindsym $mod+s layout stacking
        bindsym $mod+w layout tabbed
        bindsym $mod+e layout toggle split

      # toggle tiling / floating
        bindsym $mod+Shift+space floating toggle

      # change focus between tiling / floating windows
        bindsym $mod+space focus mode_toggle

      # focus the parent container
        bindsym $mod+a focus parent

      # focus the child container
      #bindsym $mod+d focus child

      # Define names for default workspaces for which we configure key bindings later on.
      # We use variables to avoid repeating the names in multiple places.
        set $ws1 "1"
        set $ws2 "2"
        set $ws3 "3"
        set $ws4 "4"
        set $ws5 "5"
        set $ws6 "6"
        set $ws7 "7"
        set $ws8 "8"
        set $ws9 "9"
        set $ws10 "10"

      # switch to workspace
        bindsym $mod+1 workspace $ws1
        bindsym $mod+2 workspace $ws2
        bindsym $mod+3 workspace $ws3
        bindsym $mod+4 workspace $ws4
        bindsym $mod+5 workspace $ws5
        bindsym $mod+6 workspace $ws6
        bindsym $mod+7 workspace $ws7
        bindsym $mod+8 workspace $ws8
        bindsym $mod+9 workspace $ws9
        bindsym $mod+0 workspace $ws10

      # move focused container to workspace
        bindsym $mod+Shift+1 move container to workspace $ws1
        bindsym $mod+Shift+2 move container to workspace $ws2
        bindsym $mod+Shift+3 move container to workspace $ws3
        bindsym $mod+Shift+4 move container to workspace $ws4
        bindsym $mod+Shift+5 move container to workspace $ws5
        bindsym $mod+Shift+6 move container to workspace $ws6
        bindsym $mod+Shift+7 move container to workspace $ws7
        bindsym $mod+Shift+8 move container to workspace $ws8
        bindsym $mod+Shift+9 move container to workspace $ws9
        bindsym $mod+Shift+0 move container to workspace $ws10

      # reload the configuration file
        bindsym $mod+Shift+c reload
      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
        bindsym $mod+Shift+r restart
      # exit i3 (logs you out of your X session)
        bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'"

      # resize window (you can also use the mouse for that)
        mode "resize" {
      # These bindings trigger as soon as you enter the resize mode

      # Pressing left will shrink the window’s width.
      # Pressing right will grow the window’s width.
      # Pressing up will shrink the window’s height.
      # Pressing down will grow the window’s height.
          bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

      # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

      # back to normal: Enter or Escape or $mod+r
        bindsym Return mode "default"
        bindsym Escape mode "default"
        bindsym $mod+r mode "default"
        }

        bindsym $mod+r mode "resize"

        hide_edge_borders both

    '';
  };

  home.stateVersion = "22.05";
}
