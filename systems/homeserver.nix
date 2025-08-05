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

  services.nfs.server = {
    enable = true;
    exports = ''
      /export 192.168.1.*(rw,fsid=0,no_subtree_check) 192.168.1.3(rw,fsid=0,no_subtree_check)  100.100.0.0/24(rw,fsid=0,no_subtree_check) 100.100.100.0/24(rw,fsid=0,no_subtree_check) 100.115.92.0/23(rw,fsid=0,no_subtree_check) 
    '';

    # fixed rpc.statd port; for firewall
    lockdPort = 4001;
    mountdPort = 4002;
    statdPort = 4000;
    extraNfsdConfig = '''';
  };
}
