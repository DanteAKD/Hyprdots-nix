#!/usr/bin/env bash

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="Iris's Keybinds" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" " = " \
"SUPER KEY (Windows Key Button)" "(SUPER KEY)" \
" BACKSPACE" "Log Out" "Exit Immediately" \
"Power Button" "Shutdown" "Shutdown Immediately" \
"Home Button" "Restart" "Restart Immediately" \
"" "" "" \
" H" "Launch this keybind list" "" \
" Enter" "Terminal" "(cool retro terminal)" \
" Q" "close window" "(not kill)" \
" F" "Fullscreen" "Toggles to full screen" \
" W" "Toggle float" "single window" \
" Shift Q " "kills an active window" "(kill)" \
" SHIFT R" "Reload Hyprland" "" \
"F11" "show notifications" "(dunst)" \
"F12" "hide all notifications" "(dunst)" \
" S" "Hidden Workspace" "Separate from original workspaces" \
" V" "Move To Hidden Workspace" "Move window from original workspace to special workspace" \
"" "" "" \
" SPACE" "Application Launcher" "(rofi-wayland)" \
" V" "Clipboard Manager" "(cliphist + rofi)" \
" Period" "Emoji to clipboard" "(cliphist + rofi)" \
" Shift S" "screenshot region" "(swappy)" \
" Shift W" "Choose wallpaper" "(imagemagick + swww)" \
" R" "Close / open waybar" "Activate waybar when its not there and vice versa" \
"" "" "" \
" P" "View processes" "(htop)" \
" T" "Open File Manager" "(ranger)" \
"ALT S" "Local TUI Music Player" "(cmus)" \
"" "" "" \
