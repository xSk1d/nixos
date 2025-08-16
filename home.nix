{ config, pkgs, ... }:
{
  home.username = "skid";
  home.homeDirectory = "/home/skid";
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  # tiny proof it's working
  home.packages = with pkgs; [ 
    vscode
    nixd
    neovim
    home-manager
  ];
  programs.fish.enable = true;
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true; 

  programs.ssh = {
  enable = true;
  extraConfig = ''
    Host github.com
      IdentityFile ~/.ssh/id_ed25519
      AddKeysToAgent yes
    '';
  };

}
