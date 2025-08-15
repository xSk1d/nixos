{ config, pkgs, ... }:
{
  home.username = "skid";
  home.homeDirectory = "/home/skid";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # tiny proof it's working
  home.packages = with pkgs; [ 
    neovim
    home-manager
  ];
  programs.fish.enable = true;
}
