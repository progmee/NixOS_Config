{ config, pkgs, ... }:

{
  # Enable and configure fzf (interactive fuzzy finder)
  programs.fzf = {
    enable = true;
    enableZshIntegration = true; # Automatically enables Ctrl+R, Ctrl+T, and Alt+C keybindings in Zsh
    
    # Visual and interactive customization options
    defaultOptions = [
      "--height 100%"
      "--border"
      "--reverse"
      
      # 1. File preview using bat (with syntax highlighting)
      "--preview 'bat --style=numbers --color=always --line-range :300 {}'"
      "--preview-window 'right:60%'"
      
      # 2. Open the selected file in micro on Ctrl+E and exit fzf
      "--bind 'ctrl-o:execute(micro {})+abort'"
      
      # 3. Copy file path to system clipboard on Ctrl+Y (adjust wl-copy/xclip depending on your display server)
      "--bind 'ctrl-y:execute-silent(echo -n {} | wl-copy)+abort'"
    ];
  };
}