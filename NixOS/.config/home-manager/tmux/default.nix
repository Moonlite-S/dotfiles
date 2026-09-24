{ pkgs, ... }:
let
  # The plain-file auto-concat in keymaps/ can only builtins.readFile
  # static *.conf files into the top-level extraConfig - no Nix
  # interpolation, and (per home-manager's tmux module source,
  # modules/programs/tmux.nix) top-level extraConfig is always
  # lib.mkAfter'd to the very end, after every plugin's run-shell line.
  # resurrect/continuum's @-options need to be visible to their own
  # script *before* that script runs (continuum checks
  # @continuum-restore at run-shell time to decide whether to
  # auto-restore) - too late if set via the generic extraConfig
  # mechanism. So those two go through each plugin's own submodule
  # `extraConfig` field instead (`{ plugin = ...; extraConfig = ...; }`
  # in the plugins list below), which home-manager emits immediately
  # before that specific plugin's run-shell line. Content still lives
  # in real plain .conf files (tmux/plugins/*.conf) per this repo's
  # convention - only wired in here instead of via a generic
  # auto-discovering folder module, since the ordering requirement is
  # plugin-specific, not a generic "any .conf file" concern.
  sessionizer = pkgs.writeShellApplication {
    name = "tmux-sessionizer";
    runtimeInputs = [
      pkgs.fzf
      pkgs.zoxide
    ];
    text = builtins.readFile ./scripts/sessionizer.sh;
  };
in
{
  imports = [
    ./keymaps
  ];

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    shortcut = "space";
    terminal = "tmux-256color";

    extraConfig =
      builtins.readFile ./theme.conf
      + ''
        bind-key -n M-f display-popup -E -w 80% -h 80% '${sessionizer}/bin/tmux-sessionizer'
      '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = resurrect;
        extraConfig = builtins.readFile ./plugins/resurrect.conf;
      }
      {
        plugin = continuum;
        extraConfig = builtins.readFile ./plugins/continuum.conf;
      }
      vim-tmux-navigator
      tmux-powerline
    ];
  };
}
