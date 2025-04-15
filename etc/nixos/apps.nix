{
  config,
  lib,
  pkgs,
  ...
}: {
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import <unstable> {};
      nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
    };
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    fira-code
    fira-code-symbols
    font-awesome
    jetbrains-mono
  ];

  programs.adb.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
      glibc
      cmake
      gdb
      libgcc
      libclang
      clang-tools
    ];
  };

  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      package = pkgs.utterly-nord-plasma;
      name = "Utterly Nord Plasma";
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # program.<name>.enable in home manager auto install pkgs
  environment.systemPackages = with pkgs; [
    #Virtual
    bottles

    #dev
    python3 # The Python interpreter
    python3Packages.pip # Optional: Package installer
    python3Packages.virtualenv
    glib
    clang-tools
    vscode
    vim
    wget
    git
    gdb
    gcc
    nodejs_23
    pnpm
    obsidian
    gitui

    #system
    pciutils
    home-manager
    ranger
    fastfetch
    brightnessctl
    htop
    networkmanagerapplet
    pavucontrol
    atool
    zip
    unzip
    p7zip
    usbutils
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    nautilus
    sushi
    nwg-look

    # Media
    telegram-desktop
    vesktop
    ani-cli
    mpv
    cmus
    youtube-music

    #Others
    krita
    ueberzugpp
    zoom-us
    obs-studio
    obs-studio-plugins.wlrobs
    cava
    cbonsai
    cmatrix
    eog
    spicetify-cli
    scrcpy
    qtscrcpy
    #Environment
    jq
    swappy
    gtk2
    gtk3
    gtk4
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
  services.gvfs.enable = true;
  services.flatpak.enable = true;
  #Gaming
  virtualisation.waydroid.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
  services.gvfs.enable = true;
  services.flatpak.enable = true;
  #Gaming
  virtualisation.waydroid.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
    ];
}
