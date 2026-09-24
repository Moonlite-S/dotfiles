{ config, pkgs, ... }:

{
  imports = [
    ./tmux
    ./nvim
  ];

  # home-manager (used standalone here, non-flake) evaluates its own
  # pkgs - it doesn't inherit /etc/nixos/configuration.nix's own
  # nixpkgs.config.allowUnfree, so this is needed separately for any
  # unfree package pulled in from here (currently: scope-nvim, see
  # nvim/plugins/default.nix).
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "shawnlings";
  home.homeDirectory = "/home/shawnlings";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # wl-copy/wl-paste - the actual missing piece for system-clipboard
    # access on Wayland (niri). Without this, nothing (nvim's clipboard
    # provider, tmux's OSC-52 passthrough, or any CLI tool trying to
    # read binary/image clipboard data) can talk to the Wayland
    # clipboard at all. Text copy/paste can limp along via terminal-
    # native mechanisms (ghostty's own OSC 52 handling) without it,
    # which is why only image paste specifically was failing.
    pkgs.wl-clipboard
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/shawnlings/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Bazecor's Electron process silently dies before mapping a window under
  # niri's native Wayland ozone backend + the NVIDIA driver (recurring SIGABRT,
  # see coredumpctl); forcing XWayland via xwayland-satellite works around it.
  # This overrides the system package's desktop entry: home-manager writes it
  # to ~/.nix-profile/share/applications, which precedes /run/current-system/sw/share
  # in XDG_DATA_DIRS. The attribute name must match the original file's
  # capitalization ("Bazecor") exactly, since desktop-entry IDs are
  # case-sensitive filenames — a mismatched case here (e.g. "bazecor") produces
  # a second, non-overriding launcher entry instead of replacing the original.
  xdg.desktopEntries.Bazecor = {
    name = "Bazecor";
    exec = "bazecor --ozone-platform=x11 %U";
    icon = "bazecor";
    categories = [ "Utility" ];
  };

  # qt5ct/qt6ct ship their own launcher entries, which clutter the
  # Noctalia app launcher (Modules/Panels/Launcher/Providers/
  # ApplicationsProvider.qml filters on noDisplay/hidden, same as any
  # standard launcher). They're still needed as packages (qt.platformTheme
  # = "qt5ct" in configuration.nix, plus qt6ct for Qt6 apps) - only the
  # launcher visibility is unwanted. Same override mechanism as Bazecor
  # above: home-manager writes these to ~/.nix-profile/share/applications,
  # which precedes /run/current-system/sw/share in XDG_DATA_DIRS, so the
  # noDisplay copy shadows the system one instead of adding a duplicate.
  xdg.desktopEntries.qt5ct = {
    name = "Qt5 Settings";
    exec = "qt5ct";
    noDisplay = true;
  };
  xdg.desktopEntries.qt6ct = {
    name = "Qt6 Settings";
    exec = "qt6ct";
    noDisplay = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
