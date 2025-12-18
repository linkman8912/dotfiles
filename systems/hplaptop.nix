{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, ... }:

{
  networking.hostName = "dumbandgay";
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/efcd82c8-8126-4611-aa92-b3653b9695e2";
    fsType = "btrfs";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
# boot options for fstab. Search up fstab mount options you can use
      "nofail" # Prevent system from failing if this drive doesn't mount

    ];
  };
  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-uuid/efcd82c8-8126-4611-aa92-b3653b9695e2";
  };
}
