{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, ... }:

{
  environment.systemPackages = with pkgs; [
### BROWSERS ###
    firefox
      inputs.zen-browser.packages."${pkgs.system}".default
      brave
      browsh
      floorp
      lynx
### EDITORS ###
      vim
      emacs
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
      nil
      python312Packages.python-lsp-server
      pylyzer
      pyright
      lua-language-server

### CAD ###
      openscad
      pkgs-stable.kicad
      blender
      logisim
      prusa-slicer
### MUSIC ###
      flac2all
      playerctl
      mpd
      mopidy
      mopidy-mpd
      mopidy-mopify
      mopidy-iris
      audacity
      spotify
      pkgs-stable.cava
### VIDEO ###
      vlc
      handbrake
      mpv
### SYSTEM ###
      wl-clipboard
      git-lfs
      exfatprogs
      zip
      unzip
      arp-scan
      networkmanager
      pciutils
      litemdview
      killall
      btop
      ventoy-full
      wget
      winetricks
      jdk17
      openjdk17
      nodejs_23
      kdePackages.polkit-kde-agent-1
      xwayland
      python3
      flatpak
      node2nix
      gparted
      blueman
      wine
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
      meteor
      gcc
      dotnetCorePackages.sdk_8_0_3xx
      p7zip
      appimage-run
      git
      baobab
### TERMINAL TOOLS ###
      fzf
      unp
      croc
      most
      git-filter-repo
      bfg-repo-cleaner
      tldr
      brillo
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
      protonvpn-gui
      wireguard-ui
      wireguard-tools
      qbittorrent
### PROGRAMMING ###
      hugo
### KEYBOARD ###
      vial
      via
      kmonad
      kanata
      input-remapper
### HYPR/PRETTY THINGS ###
      grimblast
      hyprpolkitagent
      hyprland
      hyprpanel
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
### GAMES ###
      everest-mons
      dolphin-emu
      itch
      ryujinx
      amidst
      gamescope
      prismlauncher
      bastet
      ninvaders
      nsnake
      bsdgames
      moon-buggy
      superTux
      superTuxKart
      gamemode
      playonlinux
      lutris
      protonup-qt
      protontricks
      samrewritten
# GAMEDEV #
      godot_4
      unityhub
### VMs ###
      vmware-workstation
### BORING (SCHOOL/PRODUCTIVITY) ###
      zoom-us
      libreoffice-qt6-still
      jrnl
### COMMUNICATION ###
      vesktop
      hexchat
### PHOTOGRAPHY/VIDEO EDITING ###
      darktable
      kdePackages.kolourpaint
      gimp-with-plugins
      kdePackages.kdenlive
      obs-studio
      inkscape
### REMOTE DESKTOP ###
      moonlight-qt
### OTHER ###
      ollama
      waydroid
      motrix
      ];
}

