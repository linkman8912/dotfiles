{ config, pkgs, inputs, pkgs-stable, home-manager, spicetify-nix, ... }:

{
  networking.hostName = "nixos";
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
