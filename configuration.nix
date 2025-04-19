# Edit this configuration file to define what should be installed on
{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, lib, chaotic, ... }:

{
  imports = 
    [ 
    ./config/stylix.nix
# ./config/udev/udev.nix
      inputs.spicetify-nix.nixosModules.default
      ./packages.nix
    ];

# Enable OpenGL
  hardware = {
    graphics = {
      enable = true;
# driSupport = true;
# driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      ];
    };
    bluetooth = {
      enable = true; # enables support for bluetooth
        powerOnBoot = true; # powers up the default bluetooth controller on boot
    };
  };

  /*
     hardware.nvidia = {
# Modesetting is required
modesetting.enable = true;
powerManagement = {
# Nvidia power management. Experimental, and can cause sleep/suspend to fail.
# enable this if you have graphical corruption issues or application crashes after waking
# up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
# of just the bare essentials
enable = false;

# Fine-grained power management. Turns off GPU when not in use.
# Experimental and only works on modern Nvidia GPUs (Turing or newer).
finegrained = false;
};

# Use the Nvidia open source kernel module (not to be confused with the
# independent third-party "nouveau" open source driver).
# Support is limited to the Turing and later architectures. Full list of
# supported GPUs is at:
# https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
# Only available from driver 515.43.04+
# Currently alpha-quality/buggy, so false is currently the recommended setting.
open = false;

# Enable the Nvidia settings menu,
# accessible via 'nvidia-settings'.
nvidiaSettings = true;

# Optionally, you may need to select the appropriate driver version for your specific GPU.
package = config.boot.kernelPackages.nvidiaPackages.stable;

prime = {
sync.enable = true;
};
};
   */

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

systemd.user.services.dropbox = {
  description = "Dropbox";
  wantedBy = [ "graphical-session.target" ];
  environment = {
    QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
    QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
  };
  serviceConfig = {
    ExecStart = "${lib.getBin pkgs.dropbox}/bin/dropbox";
    ExecReload = "${lib.getBin pkgs.coreutils}/bin/kill -HUP $MAINPID";
    KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
    PrivateTmp = true;
    ProtectSystem = "full";
    Nice = 10;
  };
};

# networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
networking.networkmanager.enable = true;

# Set your time zone.
time.timeZone = "America/New_York";

# Select internationalisation properties.
i18n.defaultLocale = "en_US.UTF-8";

i18n.extraLocaleSettings = {
  LC_ADDRESS = "en_US.UTF-8";
  LC_IDENTIFICATION = "en_US.UTF-8";
  LC_MEASUREMENT = "en_US.UTF-8";
  LC_MONETARY = "en_US.UTF-8";
  LC_NAME = "en_US.UTF-8";
  LC_NUMERIC = "en_US.UTF-8";
  LC_PAPER = "en_US.UTF-8";
  LC_TELEPHONE = "en_US.UTF-8";
  LC_TIME = "en_US.UTF-8";
};

virtualisation = {
  virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
  };
  vmware = {
    host = {
      enable = true;
    };
  };
  libvirtd.enable = true;
  spiceUSBRedirection.enable = true;
  docker = {
    enable = true;
  };
};
users = {
  extraGroups = {
    vboxusers.members = [ "linkman" ];
  };
  users.linkman = {
    isNormalUser = true;
    description = "linkman";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
#  thunderbird
    ];
  };
  groups = {
    input = {
      members = [ "linkman" ];
    };
    uinput = {
      members = [ "linkman" ];
    };
    libvirtd = {
      members = [ "linkman" ];
    };
  };

};

services = {
  xserver = {
    enable = true;
    displayManager = {
      gdm.enable = true;
    };
    desktopManager = {
      # gnome.enable = true;
    };
    xkb = {
      layout = "us";
      variant = "dvorak";
    };
# videoDrivers = [ "nvidia" ];
  };
  desktopManager = {
    plasma6.enable = true;
  };
  udev = {
    packages = with pkgs; [
      via
        vial
    ];
    extraRules = ''
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
      '';
  };
  printing.drivers = [ 
    pkgs.gutenprint # — Drivers for many different printers from many different vendors.
    pkgs.gutenprintBin # — Additional, binary-only drivers for some printers.
    pkgs.hplip # — Drivers for HP printers.
    pkgs.hplipWithPlugin # — Drivers for HP printers, with the proprietary plugin. Use NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup' to add the printer, regular CUPS UI doesn't seem to work.
    pkgs.postscript-lexmark # — Postscript drivers for Lexmark
    pkgs.samsung-unified-linux-driver # — Proprietary Samsung Drivers
    pkgs.splix # — Drivers for printers supporting SPL (Samsung Printer Language).
    pkgs.brlaser # — Drivers for some Brother printers
    pkgs.brgenml1lpr #  — Generic drivers for more Brother printers [1]
    pkgs.brgenml1cupswrapper  # — Generic drivers for more Brother printers [1]
    pkgs.cnijfilter2 # — Drivers for some Canon Pixma devices (Proprietary driver)
    pkgs.canon-cups-ufr2
    pkgs.cups-bjnp
  ]; 

  avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  mopidy = let
    mopidyPackagesOverride = pkgs.mopidyPackages.overrideScope (prev: final: {
        extraPkgs = pkgs: [ pkgs.yt-dlp ];
        });
  in {
    extensionPackages = with mopidyPackagesOverride; [
      mopidy-youtube
      mopidy-mpd
      mopidy-mopify
      mopidy-iris
      mopidy-local
    ];
    configuration = ''
      [youtube]
      youtube_dl_package = yt_dlp
        '';
  };
  /* mpd = {
    enable = true;
    musicDirectory = "/home/linkman/Music/";
    extraConfig = ''
      db_file		"~/.mpd/database"
      state_file	"~/.mpd/state"
      audio_output {
        type "pulse"
          name "Music"
          server "127.0.0.1" # add this line - MPD must connect to the local sound server
      }
     '';

# Optional:
# network.listenAddress = "any"; # if you want to allow non-localhost connections
# network.startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  }; */
};
#programs.ssh.askPassword = "${pkgs.gnome.seahorse}/libexec/seahorse/ssh-askpass";
programs.fish.enable = true;

# Configure console keymap
  console.keyMap = "dvorak";

# Enable CUPS to print documents.
  services.printing.enable = true;


# Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  hardware.pulseaudio.extraConfig = "load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1";
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
# If you want to use JACK applications, uncomment this
#jack.enable = true;

# use the example session manager (no others are packaged yet so this is enabled by default,
# no need to redefine it in your config for now)
#media-session.enable = true;
  };

# Allow unfree packages
  nixpkgs = {
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "fluffychat-linux-1.22.1"
        "olm-3.2.16"
      ];
    };
    overlays = [
#			(final: prev: {
#    				gnome.gnome-backgrounds = final.gnome-backgrounds;
#  			})

#(final: prev: {
#	gnome._gdkPixbufCacheBuilder_DO_NOT_USE = final._gdkPixbufCacheBuilder_DO_NOT_USE;
#})

      (final: _prev: {
       stable = import pkgs-stable {
       inherit (final) system config;
       };
       })
    (self: super: rec {
# https://github.com/NixOS/nixpkgs/blob/c339c066b893e5683830ba870b1ccd3bbea88ece/nixos/modules/programs/nix-ld.nix#L44
# > We currently take all libraries from systemd and nix as the default.
     pythonldlibpath = lib.makeLibraryPath (with super; [
         zlib zstd stdenv.cc.cc curl openssl attr libssh bzip2 libxml2 acl libsodium util-linux xz systemd
     ]);
# here we are overriding python program to add LD_LIBRARY_PATH to it's env
     python = super.stdenv.mkDerivation {
     name = "python";
     buildInputs = [ super.makeWrapper ];
     src = super.python311;
     installPhase = ''
     mkdir -p $out/bin
     cp -r $src/* $out/
                  wrapProgram $out/bin/python3 --set LD_LIBRARY_PATH ${pythonldlibpath}
                  wrapProgram $out/bin/python3.11 --set LD_LIBRARY_PATH ${pythonldlibpath}
                  '';
     };
     poetry = super.stdenv.mkDerivation {
     name = "poetry";
     buildInputs = [ super.makeWrapper ];
     src = super.poetry;
     installPhase = ''
     mkdir -p $out/bin
     cp -r $src/* $out/
     wrapProgram $out/bin/poetry --set LD_LIBRARY_PATH ${pythonldlibpath}
     '';
     };
     })
     ];

                  };

                  fonts.packages = with pkgs; [
                  nerdfonts
                  meslo-lgs-nf
                  poppins
                  ];

                  programs = {
                  neovim = {
                  enable = true;
      defaultEditor = true;
      /*plugins = with pkgs.vimPlugins; [
        lazy-nvim
        ];
        extraLuaConfig = ''
        vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
        require("lazy").setup({
        performance = {
        reset_packpath = false,
        rtp = {
        reset = false,
        }
        },
        dev = {
        path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
        },
        install = {
        -- Safeguard in case we forget to install a plugin with Nix
        missing = false,
        },
        })
        '';*/
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      withUWSM  = true;
    };
    virt-manager = {
      enable = true;
    };
    uwsm = {
      enable = true;
    };
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        zlib zstd stdenv.cc.cc curl openssl attr libssh bzip2 libxml2 acl libsodium util-linux xz systemd
      ];
    };
  };

catppuccin = {
  enable = true;
    flavor = "mocha";
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ANDROID_USER_HOME="$XDG_DATA_HOME/android";
    HISTFILE="$XDG_STATE_HOME/bash/history";
    DOCKER_CONFIG="$XDG_CONFIG_HOME/docker";
    DOTNET_CLI_HOME="$XDG_DATA_HOME/dotnet";
    GNUPGHOME="$XDG_DATA_HOME/gnupg";
    GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
    NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history";
    WINEPREFIX="$XDG_DATA_HOME/wine";
    CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv";
    _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java";
    XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose";
    NUGET_PACKAGES="$XDG_CACHE_HOME/NuGetPackages";
# XDG BASE DIRECTORIES
    XDG_CONFIG_HOME="$HOME/.config";
    XDG_STATE_HOME="$HOME/.local/state";
    XDG_CACHE_HOME="$HOME/.cache";
    XDG_DATA_HOME="$HOME/.local/share";
  };

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

# List services that you want to enable:

# Enable the OpenSSH daemon.
  services = {
    openssh.enable = true;
    blueman.enable = true;
    sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    tailscale.enable = true;
    flatpak = { 
      enable = true;
      packages = [
      { appId = "io.github.everestapi.Olympus"; origin = "flathub";  }
      "app.zen_browser.zen"
        "com.spotify.Client"
      ];
    };
  };

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall = {
    allowedUDPPorts = [ 57621 17500 ];
    allowedTCPPorts = [ 17500 ];
  };
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

    nix.settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

  nix.optimise.automatic = true;

  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16*1024;
  } ];

}
