_: {
  programs.alacritty = {
    enable = true;

    settings = {
      colors = {
        primary = {
          background = "#21252e";
          foreground = "#eeedee";
        };

        cursor = {
          text = "#000000";
          cursor = "#7f7f7f";
        };

        selection = {
          text = "#000000";
          background = "#b4d5ff";
        };

        normal = {
          black = "#4f4f4f"; # color0
          red = "#fa6c5f"; # color1
          green = "#a8fe60"; # color2
          yellow = "#586eae"; # color3
          blue = "#6b82ba"; # color4
          magenta = "#6383cf"; # color5
          cyan = "#6383aa"; # color6
          white = "#eeedee"; # color7
        };

        bright = {
          black = "#7b7b7b"; # color8
          red = "#fcb6af"; # color9
          green = "#ceffab"; # color10
          yellow = "#fffecc"; # color11
          blue = "#b5dcfe"; # color12
          magenta = "#fb9bfe"; # color13
          cyan = "#dfdffd"; # color14
          white = "#fefffe"; # color15
        };
      };

      font = {
        size = 13.0;
        normal = {
          family = "JetBrains Mono Nerd Font";
          style = "SemiBold";
        };
      };

      window = {
        decorations = "none";
        padding = {
          x = 15;
          y = 15;
        };
      };
    };
  };
}
