# Don't use this on an actual server

{ config, pkgs, lib, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };
  networking.hostName = "homeserver";
  services.displayManager.gdm.enable = lib.mkForce false;
}
