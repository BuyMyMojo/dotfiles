{
  description = "Current git build of shadps4";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?rev=cfd19cdc54680956dc1816ac577abba6b58b901c"; # Same as https://github.com/shadps4-emu/shadPS4/blob/main/shell.nix
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        system = "x86_64-linux";
      };
    in
    {

      packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
        name = "shadps4-git";
        pname = "shadps4";

        src = pkgs.fetchFromGitHub {
          owner = "shadps4-emu";
          repo = "shadPS4";
          rev = "a707d31a4c23fdd8aefb146ae04d25ecbca246d0";
          hash = "sha256-ZOuhdZuLXbR3kzNwoK7jioFy+MjKL8GDBtVRsyGcL98=";
          fetchSubmodules = true;
          leaveDotGit = true;
        };

        nativeBuildInputs = [
          pkgs.llvmPackages_18.clang
          pkgs.cmake
          pkgs.pkg-config
          pkgs.git
          pkgs.qt6.wrapQtAppsHook
        ];

        buildInputs = [
          pkgs.alsa-lib
          pkgs.libpulseaudio
          pkgs.openal
          pkgs.openssl
          pkgs.zlib
          pkgs.libedit
          pkgs.udev
          pkgs.libevdev
          pkgs.SDL2
          pkgs.jack2
          pkgs.sndio
          pkgs.qt6.qtbase
          pkgs.qt6.qttools
          pkgs.qt6.qtmultimedia

          pkgs.vulkan-headers
          pkgs.vulkan-utility-libraries
          pkgs.vulkan-tools

          pkgs.ffmpeg
          pkgs.fmt
          pkgs.glslang
          pkgs.libxkbcommon
          pkgs.wayland
          pkgs.xorg.libxcb
          pkgs.xorg.xcbutil
          pkgs.xorg.xcbutilkeysyms
          pkgs.xorg.xcbutilwm
          pkgs.sdl3
          pkgs.stb
          pkgs.qt6.qtwayland
          pkgs.wayland-protocols
          pkgs.libpng
        ];

        # buildPhase = ''
        #   # === setup ===
        #   export QT_QPA_PLATFORM="wayland"
        #   export QT_PLUGIN_PATH="${pkgs.qt6.qtwayland}/lib/qt-6/plugins:${pkgs.qt6.qtbase}/lib/qt-6/plugins"
        #   export QML2_IMPORT_PATH="${pkgs.qt6.qtbase}/lib/qt-6/qml"
        #   export CMAKE_PREFIX_PATH="${pkgs.vulkan-headers}:$CMAKE_PREFIX_PATH"

        #   # OpenGL
        #   export LD_LIBRARY_PATH="${
        #     pkgs.lib.makeLibraryPath [
        #       pkgs.libglvnd
        #       pkgs.vulkan-tools
        #     ]
        #   }:$LD_LIBRARY_PATH"

        #   export LDFLAGS="-L${pkgs.llvmPackages_18.libcxx}/lib -lc++"
        #   export LC_ALL="C.UTF-8"
        #   export XAUTHORITY=${builtins.getEnv "XAUTHORITY"}
        #   # === setup ===

        #   # === build ===
        #   cmake -S . -B build/ -DENABLE_QT_GUI=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
        #   # cmake --build ./build --parallel $(nproc)
        #   # === build ===
        # '';

        # installPhase = ''
        #   cmake --install . --parallel $(nproc)
        # '';

        cmakeFlags = [
          (nixpkgs.lib.cmakeBool "ENABLE_QT_GUI" true)
          (nixpkgs.lib.cmakeBool "ENABLE_UPDATER" false)
        ];

        # Still in development, help with debugging
        # cmakeBuildType = "RelWithDebugInfo";
        # dontStrip = true;

        installPhase = ''
          runHook preInstall

          install -D -t $out/bin shadps4
          install -Dm644 $src/.github/shadps4.png $out/share/icons/hicolor/512x512/apps/net.shadps4.shadPS4.png
          install -Dm644 -t $out/share/applications $src/dist/net.shadps4.shadPS4.desktop
          install -Dm644 -t $out/share/metainfo $src/dist/net.shadps4.shadPS4.metainfo.xml

          runHook postInstall
        '';

        runtimeDependencies = [
          pkgs.vulkan-loader
          pkgs.xorg.libXi
        ];

      };

    };
}
