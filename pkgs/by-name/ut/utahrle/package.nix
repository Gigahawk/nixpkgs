{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "utahrle";
  version = "0-unstable-2024-09-17";

  src = fetchFromGitHub {
    owner = "BRL-CAD";
    repo = "utahrle";
    rev = "af1fe23824e2ea1865bfa4b35be0cbc9d4c7177d";
    hash = "sha256-c16VjcMCRNCQFVp3jL39wsW9Y5WBcH5IDDR3NObM1Sk=";
  };

  nativeBuildInputs = [
    cmake
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-std=gnu89"
  ];

  meta = {
    description = "Utah Raster Toolkit RLE image library";
    homepage = "https://github.com/BRL-CAD/utahrle";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
