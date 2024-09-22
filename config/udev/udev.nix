{ lib, inputs, pkgs, config, ... }:

{
	services.udev.extraRules = ''
	ACTION=="add", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="1038" RUN+="/home/linkman/.dotfiles/config/udev/steelseries-perms.py '%E{DEVNAME}'"
	'';
}
