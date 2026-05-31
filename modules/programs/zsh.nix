{ pkgs, ... }:

{
  # Shell configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true; 
    autosuggestions.enable = true; 
    syntaxHighlighting.enable = true; 
  };

  programs.direnv.enable = true;

  # Zoxide navigation (replaces cd)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Starship (System-wide for now)
  programs.starship = {
    enable = true;
    settings = {
      palette = "grey";
      format = "$username$hostname$directory$fill$cmd_duration$time$line_break$character";
      character = {
        success_symbol = "[@](bold green)";
        error_symbol = "[@](bold red)";
      };
      fill = { symbol = "─"; style = "#222222"; };
      palettes.grey = {
        grey = "#777777";
        blue = "#777777"; cyan = "#777777";
        green = "#777777";
        magenta = "#777777"; red = "#777777"; yellow = "#777777";
      };
    };
  };
}
