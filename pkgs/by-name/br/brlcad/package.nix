{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch,
  cmake,
  pkg-config,
  fontconfig,
  libx11,
  libxi,
  freetype,
  libgbm,

  lief,
  pugixml,
  opencv,
  clipper2,

  lemon,
  re2c,
  netpbm,
  libjpeg,
  zlib,
  libpng,
  libtiff,
  lmdb,
  eigen,
  sqlite,
  proj,
  gdal,
  tinygltf,
  openmesh,
  manifold,
  mesa,
  geogram,
  tcl,
  tclPackages,
  utahrle,
  perplex,
  regex-hs,
  stepcode,
  mmesh,
  assimp,
}:

stdenv.mkDerivation rec {
  pname = "brlcad";
  version = "7.42.0";

  srcs = [
    (fetchFromGitHub {
      owner = "BRL-CAD";
      repo = "brlcad";
      name = "brlcad";
      tag = "rel-${lib.replaceStrings [ "." ] [ "-" ] version}";
      hash = "sha256-GDhP3880jLBxYFTZsBzwd5BB7e8mVGDBMghQ9BDeAvw=";
    })
    (fetchFromGitHub {
      owner = "BRL-CAD";
      repo = "bext";
      name = "bext";
      rev = "17f3f0c802dc7a60e5f25751019c0626cdbc7094";
      hash = "sha256-0njc2gTdFKDeTVktdruQjpcdZeAjXimI6/FuL4f32M0=";
      fetchSubmodules = true;
    })
  ];
  sourceRoot = "brlcad";

  patches = [
    # This commit was bringing an impurity in the rpath resulting in:
    # RPATH of binary /nix/store/rq2hjvfgq2nvh5zxch51ij34rqqdpark-brlcad-7.38.0/bin/tclsh contains a forbidden reference to /build/
    # (fetchpatch {
    #   url = "https://github.com/BRL-CAD/brlcad/commit/fbdbf042b2db4c7d46839a17bbf4985cdb81f0ae.patch";
    #   revert = true;
    #   hash = "sha256-Wfihd7TLkE8aOpLdDtYmhhd7nZijiVGh1nbUjWr/BjQ=";
    # })
  ];
  # Is this necessary with pkg-config?
  postPatch = ''
    clipper2_files=$(grep -r -l "CLIPPER2" $NIX_BUILD_TOP/bext/*)
    substituteInPlace $clipper2_files --replace-fail "CLIPPER2" "Clipper2"
  '';

  # bext build attempts to patch files and warns that files are not writeable?
  # presumably if we provide all the libs this doesn't need to happen
  preConfigure = ''
    chmod -R 777 $NIX_BUILD_TOP/bext
  '';

  nativeBuildInputs = [
    cmake
    pkg-config # Chatgpt told me to put this here but is it necessary?
  ];

  buildInputs = [
    fontconfig
    libx11
    libxi
    freetype
    libgbm

    lief
    pugixml
    opencv
    clipper2

    lemon
    re2c
    netpbm
    libjpeg
    zlib # chatgpt says find_package(PNG) requires this???? but doesnt seem to work
    libpng
    libtiff
    lmdb
    eigen
    sqlite
    proj
    gdal
    tinygltf
    openmesh
    manifold
    mesa
    geogram
    tcl
    tclPackages.tk
    utahrle
    perplex
    regex-hs
    stepcode
    mmesh
    assimp
  ];
  #  preConfigure = ''
  #    echo "SRCS"
  #    echo "$srcs"
  #    ls -al $srcs
  #    echo "LS ."
  #    ls -al .
  #    echo "LS .."
  #    ls -al ..
  #    echo "LS $NIX_BUILD_TOP"
  #    ls -al "$NIX_BUILD_TOP"
  #    echo "LS $NIX_BUILD_TOP/bext"
  #    ls -al "$NIX_BUILD_TOP/bext"
  #    exit 1
  #
  #  '';

  cmakeFlags = [
    "-DBRLCAD_ENABLE_STRICT=OFF"
    "-DBRLCAD_EXT_SOURCE_DIR=/build/bext"
    "-DCMAKE_PREFIX_PATH=${libpng.dev}"
    "-DPNG_PNG_INCLUDE_DIR=${libpng.dev}/include"
    "-DPNG_LIBRARY=${libpng.out}/lib/libpng.so"
    "-DPNG_LIBRARY_RELEASE=${libpng.out}/lib/libpng.so"
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    # Needed with GCC 12
    "-Wno-error=array-bounds"
    "-DCMAKE_PREFIX_PATH=${libpng.dev}"
    "-DPNG_PNG_INCLUDE_DIR=${libpng.dev}/include"
    "-DPNG_LIBRARY=${libpng.out}/lib/libpng.so"
    "-DPNG_LIBRARY_RELEASE=${libpng.out}/lib/libpng.so"
  ];

  meta = {
    homepage = "https://brlcad.org";
    description = "BRL-CAD is a powerful cross-platform open source combinatorial solid modeling system";
    #changelog = "https://github.com/BRL-CAD/brlcad/releases/tag/${lib.removePrefix "refs/tags/" src.rev}";
    license = with lib.licenses; [
      lgpl21
      bsd2
    ];
    maintainers = with lib.maintainers; [ GaetanLepage ];
    platforms = lib.platforms.linux;
    # error Exactly one of ON_LITTLE_ENDIAN or ON_BIG_ENDIAN should be defined.
    broken = stdenv.system == "aarch64-linux";
  };
}
