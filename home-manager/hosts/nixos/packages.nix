{
  config,
  pkgs,
  unstable,
  gsr-ui,
  inputs,
  ...
}:

{

  home.file."jdks/zulujdk8".source = pkgs.zulu8;
  home.file."jdks/zulujdk17".source = pkgs.zulu17;
  home.file."jdks/zulujdk23".source = pkgs.zulu23;

  home.file."Godot/current".source = unstable.godot;
  home.file."Godot/current-mono".source = unstable.godot-mono;
  home.file."Godot/export-templates/current".source = unstable.godot-export-templates;
  home.file."Godot/4.3".source = unstable.godot_4_3;
  home.file."Godot/4.3-mono".source = unstable.godot_4_3-mono;
  home.file."Godot/export-templates/4.3".source = unstable.godot_4_3-export-templates;

  home.file."bin/wine".source = unstable.wineWowPackages.waylandFull;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    with unstable;
    with inputs;
    [
      pkgs.nextcloud-client
      pkgs.xpipe
      pkgs.monero-gui
      unstable.kiwix

      # pkgs.protonplus
      unstable.pcsx2
      pkgs.rpcs3
      unstable.ryubing
      unstable.torzu
      pkgs.heroic-unwrapped
      unstable.ludusavi
      inputs.shadps4-git.packages."x86_64-linux".default

      unstable.wineWowPackages.waylandFull
      unstable.winetricks
      steamtinkerlaunch

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
      unstable.yt-dlp
      pkgs.aria2
      pkgs.jujutsu
      pkgs.lazyjj
      pkgs.biome
      # === CLI ===

      # === Image CLI ===
      unstable.oxipng
      unstable.image_optim
      unstable.jpegoptim
      pkgs.libjxl
      pkgs.libavif
      pkgs.libwebp
      pkgs.imagemagick
      # === Image CLI ===

      # === Game perf ===
      unstable.mangojuice
      unstable.goverlay
      # === Game perf ===

      # === Dev tooling ===
      # pkgs.rustup
      # === Dev tooling ===

      # pkgs.polychromatic

      pkgs.lazydocker
      pkgs.distrobox
      pkgs.boxbuddy

      unstable.godot-mono
      unstable.godot-export-templates
      unstable.blender-hip
      unstable.freecad-wayland
      pkgs.unityhub
      pkgs.material-maker
      unstable.blockbench

      unstable.gpu-screen-recorder-gtk
      gsr-ui.gpu-screen-recorder-ui

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    package = unstable.mangohud;
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

  # === ssh ===
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

}
