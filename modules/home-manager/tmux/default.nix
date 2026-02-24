{config,inputs, pkgs, ... }:

let
  # Define the custom plugin locally in this file
  tmux-fzf-links = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "tmux-fzf-links";
    version = "v1.4.13";
    # src = pkgs.fetchFromGitHub {
    #   owner = "alberti42";
    #   repo = "tmux-fzf-links";
    #   rev = "v1.4.13";
    #   sha256 = "sha256-UgJa7I9AmrOdtK1RDIbdBfHl7OU5Cmx51wncWRPml18="; 
    # };
    src = inputs.tmux-fzf-links; 
  };
in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi"; # Uses vi keys for copy mode
    mouse = true;   # Enables mouse support
    shortcut = "a"; # Sets the prefix to Ctrl-a (instead of Ctrl-b)

    # Direct Home Manager options
    baseIndex = 1;
    escapeTime = 0;
    historyLimit = 10000000;
    terminal = "screen-256color";

    # Extra configuration 
    extraConfig = ''
      # Set status bar colors
      set -g status-bg black
      set -g status-fg white

      # Enable continuum restores on tmux start
      set -g @continuum-restore 'on'
      
      # For resurrect: enable capturing pane contents
      set -g @resurrect-capture-pane-contents 'on'
      
      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5
      
      bind -r m resize-pane -Z
      
      # Switch windows with Ctrl + number
      bind -n F1 select-window -t 1
      bind -n F2 select-window -t 2
      bind -n F3 select-window -t 3
      bind -n F4 select-window -t 4
      bind -n F5 select-window -t 5
      bind -n F6 select-window -t 6
      bind -n F7 select-window -t 7
      bind -n F8 select-window -t 8
      bind -n F9 select-window -t 9
      bind -n F10 select-window -t 10
      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

      # Passthrough and Activity
      set -gq allow-passthrough on
      set -g visual-activity off
      
      # Environment updates
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      # Focus and Terminal Overrides
      set-option -g focus-events on
      set-option -g terminal-overrides ',xterm-256color:RGB'

      # Behavior
      set -g detach-on-destroy off 
      set -g renumber-windows on 
      
      set -sg escape-time 10

    '';

    plugins = with pkgs.tmuxPlugins; [
          vim-tmux-navigator
          resurrect
          continuum
          # {
          #   plugin = themepack;
          #   extraConfig = "set -g @themepack 'powerline/default/cyan'"; # Choose your theme here
          # }
          {
            plugin = tmux-sessionx;
            extraConfig = ''
              set -g @sessionx-bind 'o'
              set -g @sessionx-window-height '85%'
              set -g @sessionx-window-width '75%'
            '';
          }
	  {
             plugin = tmux-fzf-links;
             extraConfig = ''
               set -g @fzf-links-key u
	       set -g @fzf-links-history-lines "0"

             '';
      	   }
        ];
    
  };
}
