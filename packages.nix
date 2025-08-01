{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, chaotic, neovim-nightly-overlay, ... }:

{
  environment.systemPackages = with pkgs; [
    # shell scripts
    (import scripts/gifconvert.nix)
    # rmpc (a specific git version)
    #(import config/rmpc/default.nix)
    (pkgs.callPackage ./config/rmpc/package.nix { })
    # a workaround
    (pkgs.writeShellScriptBin "python" ''
     export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
     exec ${pkgs.python3}/bin/python "$@"
     '')
### BROWSERS ###
    firefox
      inputs.zen-browser.packages."${pkgs.system}".default
      brave
      #browsh
      floorp
      #lynx
### EDITORS ###
      vim
      emacs
      # inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
  ## NEOVIM THINGS ##
    # linters/stylers
      eslint
      stylua
      prettierd
      black
      isort
    # LSPs
      arduino-language-server
      ast-grep
      superhtml
      hyprls
      csharp-ls
      omnisharp-roslyn
      nil
      python312Packages.python-lsp-server
      pylyzer
      pyright
      lua-language-server
      astyle
      rust-analyzer
      ccls
      roslyn-ls
### CAD ###
      openscad
      pkgs-stable.kicad
      blender
      #logisim
      prusa-slicer
### MUSIC ###
      flac2all
      playerctl
      mpd
      pkgs-stable.mpdris2
      #mpdris2
      yams
      mpc
      pkgs-stable.audacity
      plattenalbum
      # pkgs-stable.spotify
      pkgs-stable.cava
      yt-dlp
      spotdl
      rmpc
      sacad
      beets
      id3v2
      flac
      streamrip
      python313Packages.syncedlyrics
### VIDEO ###
      vlc
      handbrake
      mpv
### SYSTEM ###
      wl-clipboard
      rustc
      cargo
      fd
      #toybox
      git-lfs
      lazygit
      wf-recorder
      slurp
      exfatprogs
      zip
      unzip
      arp-scan
      networkmanager
      pciutils
      litemdview
      killall
      btop
      #ventoy-full
      wget
      winetricks
      jdk17
      openjdk17
      nodejs_latest
      kdePackages.polkit-kde-agent-1
      xwayland
      python3
      usbutils
      poetry
      flatpak
      node2nix
      gparted
      blueman
      wine
      wine-wayland
      wine64
      python313Packages.pip
      python313Packages.tkinter
      pipx
      libwebp
      rar
      unrar
      pavucontrol
      nwg-look
      libfaketime
      lutgen
      rpi-imager
      cups
      ffmpeg_7
      wev
      libnotify
      xautoclick
      #meteor
      gcc
      #dotnetCorePackages.sdk_8_0_3xx
      dotnet-runtime_9
      dotnetCorePackages.runtime_9_0-bin
      dotnetCorePackages.sdk_9_0-bin
      dotnetCorePackages.dotnet_9.sdk
      p7zip
      appimage-run
      git
      github-cli
      baobab
      podman
      xdg-ninja
      plocate
      mlocate
      any-nix-shell
      libcap
      #xr-hardware
### TERMINAL TOOLS ###
      fzf
      unp
      croc
      most
      git-filter-repo
      bfg-repo-cleaner
      tldr
      #brillo
      bat
      brightnessctl
      ripgrep
      hyfetch
      zoxide
      feh
      lutgen
      pamixer
      eza
### SECURITY ###
      tor
      tor-browser
      #protonvpn-gui
      wireguard-ui
      wireguard-tools
      qbittorrent
### PROGRAMMING ###
      hugo
### KEYBOARD ###
      #vial
      #via
      kmonad
      kanata
      input-remapper
      ydotool
      xdotool
### HYPR/PRETTY THINGS ###
      grimblast
      hyprpolkitagent
      hyprland
      # hyprpanel
      hypridle
      catppuccin
      mpvpaper
      swww
      fuzzel
      swaynotificationcenter
      hyprlock
      hyprnotify
      hyprpicker
      hyprshot
      kitty
      rofi-wayland
      hyprpaper
      waybar
      fastfetch
      wofi
      starship
      eww
      pywal16
      ags
### GAMES ###
      #everest-mons
      dolphin-emu
      itch
      ryujinx
      #amidst
      pkgs-stable.gamescope
      # gamescope_git
      pkgs-stable.prismlauncher
      #bastet
      #ninvaders
      #nsnake
      #bsdgames
      #moon-buggy
      superTux
      superTuxKart
      gamemode
      #playonlinux
      lutris
      #protonup-qt
      protontricks
      samrewritten
      celeste64
# GAMEDEV #
      godot_4
      pkgs-stable.unityhub
### VMs ###
      vmware-workstation
### BORING (SCHOOL/PRODUCTIVITY) ###
      zoom-us
      libreoffice-qt6-still
      jrnl
### COMMUNICATION ###
      vesktop
      hexchat
      fluffychat
### PHOTOGRAPHY/VIDEO EDITING ###
      #darktable
      kdePackages.kolourpaint
      #pkgs-stable.gimp
      gimp3
      kdePackages.kdenlive
      obs-studio
      inkscape
### BACKUPS ###
      maestral
      maestral-gui
      celeste
      #dropbox
      #dropbox-cli
      syncthing
      syncthingtray
### NAS ###
      nfs-utils
### OTHER ###
      moonlight-qt
      ollama
      waydroid
      #motrix
      ];
}
