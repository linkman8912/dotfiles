{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, ... }:

{
  networking.hostName = "smartandgay";
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
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:3:0:0";
	  sync.enable = true;
	};
  };

  fileSystems."/home" = {
    device = "dev/disk/by-uuid/69563580-798b-4be0-bd1d-b3e1cbb1903b";
    fsType = "btrfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
# boot options for fstab. Search up fstab mount options you can use
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  fileSystems."/mnt/share" = {
    device = "homeserver.local:/";
    fsType = "nfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
    "x-systemd.automount" # lazy-mount
    "noauto"
# boot options for fstab. Search up fstab mount options you can use
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };



  services = {
    xserver.videoDrivers = [ "nvidia" ];
    ollama = {
      enable = true;
      acceleration = "rocm";
      environmentVariables = {
        OLLAMA_HOST = "0.0.0.0:11434";
        OLLAMA_ORIGINS = "http://0.0.0.0:11434";
      };
    };
    open-webui = {
      enable = true;
      host = "0.0.0.0";
      environment = {
        ANONYMIZED_TELEMETRY = "False";
        DO_NOT_TRACK = "True";
        SCARF_NO_ANALYTICS = "True";
        WEBUI_AUTH = "False";
      };
    };
  };
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
