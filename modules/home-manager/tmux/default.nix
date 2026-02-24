{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi"; # Uses vi keys for copy mode
    mouse = true;   # Enables mouse support
    shortcut = "a"; # Sets the prefix to Ctrl-a (instead of Ctrl-b)
    
    # Extra configuration that isn't covered by the options above
    extraConfig = ''
      # Set status bar colors
      set -g status-bg black
      set -g status-fg white
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
    '';
  };
}
