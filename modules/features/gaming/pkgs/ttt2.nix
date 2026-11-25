{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  ninja,
  pkg-config,
  git,
  python313,
  openssl,
  zlib,
  zstd,
  vulkan-loader,
  vulkan-headers,
  sdl3,
  shaderc,
  gtk4,
  gdk-pixbuf,
  pango,
  gcc,
  gamescope,
  wrapGAppsHook4,
  pkgsCross,
}:

let
  # pinned by dependencies.lock.json
  zarchive = fetchFromGitHub {
    owner = "Exzap";
    repo = "ZArchive";
    rev = "965b66c8d67b6b7e30fd63b3b75aa91a99ff303b";
    hash = "sha256-OYYVo2R0eJwLHOKzRrri69V8exRvtqA6AgPgXL/6b2I=";
  };
  addrlib = fetchFromGitHub {
    owner = "decaf-emu";
    repo = "addrlib";
    rev = "194162c47469ce620dd2470eb767ff5e42f5954a";
    hash = "sha256-hJDF9CIaPdUSKFlj8DwEln0MJ7gFJj8rZ0FCSUMHr3s=";
  };

  # ttt2-build links the game program against these on the host
  kitLibs = lib.makeLibraryPath [
    openssl
    zlib
    zstd
    vulkan-loader
    sdl3
    shaderc
  ];
in
stdenv.mkDerivation (finalAttrs: {
  pname = "tekken-tag-2-ultimate-edition";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "Petexy";
    repo = "Tekken-Tag-2-Ultimate-Edition";
    tag = "v${finalAttrs.version}";
    hash = "sha256-e10UIfeZqhh2BBvJIBDRkZo15LBVbHvh7PMuD1VmTA8=";
  };

  postUnpack = ''
    mkdir -p source/third_party
    cp -r ${zarchive} source/third_party/ZArchive
    cp -r ${addrlib} source/third_party/addrlib
  '';

  nativeBuildInputs = [
    cmake
    ninja
    pkg-config
    git
    wrapGAppsHook4
    pkgsCross.mingwW64.stdenv.cc
  ];

  buildInputs = [
    openssl
    zlib
    zstd
    vulkan-loader
    vulkan-headers
    sdl3
    shaderc
    gtk4
    gdk-pixbuf
    pango
  ];

  cmakeFlags = [
    (lib.cmakeBool "TTT2_LAUNCHER_BUILD_TREE_PATHS" false)
    (lib.cmakeFeature "Vulkan_INCLUDE_DIR" "${vulkan-headers}/include")
    (lib.cmakeFeature "Vulkan_LIBRARY" "${vulkan-loader}/lib/libvulkan.so")
    # the kit is skipped without position-independent objects
    "-DCMAKE_C_FLAGS=-fPIE"
    "-DCMAKE_CXX_FLAGS=-fPIE"
  ];

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix PATH : ${
        lib.makeBinPath [
          gamescope
          gcc
          python313
        ]
      }
      --prefix LD_LIBRARY_PATH : ${kitLibs}
    )
  '';

  meta = {
    description = "Tekken Tag Tournament 2 Ultimate Edition launcher and game kit";
    homepage = "https://github.com/Petexy/Tekken-Tag-2-Ultimate-Edition";
    license = lib.licenses.mit;
    mainProgram = "ttt2-launcher";
    platforms = [ "x86_64-linux" ];
  };
})
