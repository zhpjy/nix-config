{ pkgs, ... }:

{
  imports = [
    ../base/nushell
    
    ../base/core.nix
    ../base/git.nix
    ../base/development.nix
    ../base/media.nix
    ../base/starship.nix
    
    ./alacritty
    ./core.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = "admin";
    # set homeDirectory make build fail
    homeDirectory = "/Users/admin";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}