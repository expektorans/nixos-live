{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-gnome.nix> ];

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  environment.shellInit = ''
    export GPG_TTY="$(tty)"
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
  '';

  environment.systemPackages = [
    pkgs.pinentry
    pkgs.pinentry-gtk2
    pkgs.htop
    pkgs.pass
    pkgs.wl-clipboard
  ];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "curses";
  };

  services.pcscd.enable = true;
}
