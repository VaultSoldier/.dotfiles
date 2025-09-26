{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtmultimedia
    qt6.qtsvg
    kdePackages.kirigami
    kdePackages.breeze
    libqalculate
    material-symbols
    clazy
    rubik
    pipewire
    aubio
    libcava
    fftw
    cmake
    ninja
    pkg-config
  ];

  # cmake ./caelestia -B ./caelestia/build -G Ninja \
  #   -DCMAKE_BUILD_TYPE=Release \
  #   -DCMAKE_INSTALL_PREFIX=$HOME/.config/quickshell/caelestia \
  #   -DINSTALL_QMLDIR=$HOME/.config/quickshell/caelestia/qml \
  #   -DINSTALL_LIBDIR=$HOME/.config/quickshell/caelestia/lib \
  #   -DINSTALL_QSCONFDIR=$HOME/.config/quickshell/caelestia
  #
  # cmake --build ./caelestia/build
  # cmake --install ./caelestia/build
}

