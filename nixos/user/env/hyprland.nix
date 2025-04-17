{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
	jq
	yad
	swappy
	waybar
	dunst
	libnotify
	swww
	rofi-wayland
	cliphist
	swaylock
	imagemagick
	grim
	slurp
	wl-clipboard
	wlroots
	wlogout
];
    xdg.portal.enable = true;
    xdg.portal.extraPortals  = [pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-wlr];
    programs.hyprland = {
	enable = true;
	xwayland.enable = true;
};
    environment.sessionVariables = {
	#WLR_NO_HARDWARE_CURSORS ="1";
	NIXOS_OZONE_WL = "1";
};
}
