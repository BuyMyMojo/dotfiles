{
  config,
  pkgs,
  unstable,
  inputs,
  ...
}:

{

  imports = [
    inputs.moonlight.homeModules.default
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      inputs.moonlight.overlays.default
    ];
  };

  home.file."jdks/zulujdk8".source = pkgs.zulu8;
  home.file."jdks/zulujdk17".source = pkgs.zulu17;
  home.file."jdks/zulujdk23".source = pkgs.zulu23;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with unstable; [
    pkgs.nextcloud-client
    pkgs.yubioath-flutter
    pkgs.xpipe
    pkgs.qbittorrent
    pkgs.monero-gui

    # pkgs.protonplus
    pkgs.pcsx2
    pkgs.rpcs3
    unstable.ryubing
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
    pkgs.yt-dlp
    pkgs.aria2
    # === CLI ===

    # === Image CLI ===
    unstable.oxipng
    unstable.image_optim
    pkgs.jpegoptim
    pkgs.libjxl
    pkgs.libavif
    pkgs.libwebp
    pkgs.imagemagick
    # === Image CLI ===

    # === Communication ===
    pkgs.vesktop
    pkgs.discord-canary
    pkgs.signal-desktop
    pkgs.telegram-desktop
    # pkgs.thunderbird-latest-unwrapped
    # === Communication ===

    # === Game perf ===
    pkgs.mangojuice
    unstable.goverlay
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

  programs.moonlight-mod = {
    enable = true;
    # stable = {
    #   extensions = {
    #     allActivites.enabled = true;
    #     alwaysFocus.enabled = true;

    #     betterEmbedsYT = {
    #       enabled = true;
    #       config = {
    #         fullDescription = false;
    #         expandDescription = true;
    #       };
    #     };
    #   };
    # };
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

  programs.bash.enable = true;
  programs.fish.enable = true;

}
