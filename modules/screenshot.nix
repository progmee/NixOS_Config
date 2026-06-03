{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grim
    slurp
    satty
  ];

  home-manager.users.progme = { ... }: {
    wayland.windowManager.hyprland.extraConfig = ''
      windowrule = float on, match:class ^(com\.gabm\.satty)$
      windowrule = center on, match:class ^(com\.gabm\.satty)$
      windowrule = size 80% 80%, match:class ^(com\.gabm\.satty)$
      windowrule = stay_focused on, match:class ^(com\.gabm\.satty)$
    '';
  };
}