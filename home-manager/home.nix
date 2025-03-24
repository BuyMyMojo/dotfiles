{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {
    config = {
      allowUnfree = true;
    };
  };
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "buymymojo";
  home.homeDirectory = "/home/buymymojo";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  home.file."jdks/zulujdk8".source = pkgs.zulu8;
  home.file."jdks/zulujdk17".source = pkgs.zulu17;
  home.file."jdks/zulujdk23".source = pkgs.zulu23;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.nextcloud-client
    pkgs.yubioath-flutter
    pkgs.xpipe
    pkgs.qbittorrent
    pkgs.monero-gui


    # pkgs.protonplus
    pkgs.pcsx2
    pkgs.rpcs3
    pkgs.ryujinx
    pkgs.heroic-unwrapped
    pkgs.ludusavi


    # === Minecraft ===
    pkgs.prismlauncher
    # pkgs.zulu8
    # pkgs.zulu17
    # pkgs.zulu23
    # === Minecraft ===

    # === CLI ===
    pkgs.bat
    pkgs.btop
    pkgs.rrsync
    pkgs.ripgrep
    pkgs.wl-clipboard
    pkgs.poop # Compare the performance of multiple commands with a colorful terminal user interface
    pkgs.age
    pkgs.stow
    # === CLI ===

    # === Image CLI ===
    unstable.oxipng
    unstable.image_optim
    pkgs.jpegoptim
    pkgs.libjxl
    pkgs.libwebp
    pkgs.imagemagick
    # === Image CLI ===

    # === Communication ===
    pkgs.vesktop
    (unstable.discord.override { withMoonlight = true; }) # pkgs.discord fails to build because of `'anonymous lambda' called with unexpected argument` so we need to use unstable instead
    pkgs.signal-desktop
    pkgs.telegram-desktop
    # pkgs.thunderbird-latest-unwrapped
    # === Communication ===

    # === Game perf ===
    pkgs.mangojuice
    pkgs.goverlay
    # === Game perf ===

    # === Dev tooling ===
    # pkgs.rustup


    unstable.libreoffice-fresh
    # pkgs.kdePackages.kate
    pkgs.jetbrains.webstorm
    pkgs.jetbrains.rider
    pkgs.jetbrains.idea-community
    # === Dev tooling ===

    # === Media ===
    pkgs.gimp
    pkgs.krita
    pkgs.mpv
    unstable.losslesscut-bin
    # === Media ===

    pkgs.polychromatic

    pkgs.orca-slicer

    pkgs.lazydocker
    pkgs.distrobox
    pkgs.boxbuddy

    unstable.godot
    unstable.blender-hip
    pkgs.freecad-wayland
    pkgs.unityhub
    pkgs.material-maker

    unstable.gpu-screen-recorder
    unstable.gpu-screen-recorder-gtk

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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

  programs.git = {
    enable = true;
    userName = "BuyMyMojo";
    userEmail = "hello+git@buymymojo.net";
    lfs.enable = true;
    signing.key = "E7B7B8D20C8753C077F9B17119AB7AA462B8AB3B";
    signing.signByDefault = true;
    extraConfig = {
      init = {

      defaultBranch = "main";
      };
    };
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture
      obs-pipewire-audio-capture
      obs-teleport
      obs-source-record
      obs-source-clone
      obs-composite-blur
    ];
  };

  programs.ssh.enable = true;
  programs.ssh.addKeysToAgent = "yes";

  programs.ssh.matchBlocks = {
    "*" = {
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
    };

    "game2.buymymojo.net" = {
      hostname = "game2.buymymojo.net";
      user = "jumpbox";
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
    };

    "git.aria.coffee" = {
      hostname = "git.aria.coffee";
      user = "git";
      identityFile = "/home/buymymojo/.ssh/id_ed25519-mainpc";
      port = 23;
    };
  };

  programs.fish.enable = true;

  services.ssh-agent.enable = true;
  services.syncthing.enable = true;

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
  #  /etc/profiles/per-user/buymymojo/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "code";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
