{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, ... }:

{

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/eec8ad31-509e-454d-8e6a-f1fd0095d4df";
    fsType = "ext4";
    options = [ # If you don't have this options attribute, it'll default to "defaults" 
# boot options for fstab. Search up fstab mount options you can use
      "nofail" # Prevent system from failing if this drive doesn't mount

    ];
  };
}
