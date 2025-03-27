{
  description = "Current git build of shadps4";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?rev=cfd19cdc54680956dc1816ac577abba6b58b901c";
  };

  outputs =
    { self, nixpkgs }:
    {

      packages.x86_64-linux.default = stdenv.mkDerivation {
        name = "shadps4-git";
        pname = "shadps4";

        src = pkgs.fetchgit {
          url = "https://github.com/shadps4-emu/shadPS4";
          fetchSubmodules = true;
        };

        nativeBuildInputs = [
          pkgs.llvmPackages_18.clang
          pkgs.cmake
          pkgs.pkg-config
          pkgs.git
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

        buildPhase = ''
          # === setup ===
          export QT_QPA_PLATFORM="wayland"
          export QT_PLUGIN_PATH="${pkgs.qt6.qtwayland}/lib/qt-6/plugins:${pkgs.qt6.qtbase}/lib/qt-6/plugins"
          export QML2_IMPORT_PATH="${pkgs.qt6.qtbase}/lib/qt-6/qml"
          export CMAKE_PREFIX_PATH="${pkgs.vulkan-headers}:$CMAKE_PREFIX_PATH"

          # OpenGL
          export LD_LIBRARY_PATH="${
            pkgs.lib.makeLibraryPath [
              pkgs.libglvnd
              pkgs.vulkan-tools
            ]
          }:$LD_LIBRARY_PATH"

          export LDFLAGS="-L${pkgs.llvmPackages_18.libcxx}/lib -lc++"
          export LC_ALL="C.UTF-8"
          export XAUTHORITY=${builtins.getEnv "XAUTHORITY"}
          # === setup ===

          # === build ===
          cmake -S . -B build/ -DENABLE_QT_GUI=ON -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++
          # cmake --build ./build --parallel $(nproc)
          # === build ===
        '';

        installPhase = ''
          cmake --install ./build --parallel $(nproc)
        '';

      };

    };
}
