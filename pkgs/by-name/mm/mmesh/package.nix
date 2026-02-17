{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "mmesh";
  version = "0-unstable-2026-02-10";

  src = fetchFromGitHub {
    owner = "BRL-CAD";
    repo = "mmesh";
    rev = "9f9a1abe0567345a6a0b4b4d435323b81cebb0d0";
    hash = "sha256-rRLS+MNzr39+/6b2tEIJSo5mzQtM4oQ7zKQah6RjJzE=";
  };

  nativeBuildInputs = [
    cmake
  ];

  #  env.NIX_CFLAGS_COMPILE = toString [
  #    "-std=gnu89"
  #  ];

  meta = {
    description = "Library for Alexis Naveros's meshing routines";
    homepage = "https://github.com/BRL-CAD/mmesh";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
