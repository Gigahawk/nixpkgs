{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  re2c,
  lemon,
}:

stdenv.mkDerivation {
  pname = "perplex";
  version = "0-unstable-2023-09-16";

  src = fetchFromGitHub {
    owner = "BRL-CAD";
    repo = "perplex";
    rev = "9c2cba2719a6010ed0b940f5cf99612c207df3c6";
    hash = "sha256-S3OSdhYzX+bRE7BWJHZYZ2B6BSuagv0YgR2cIVIYlqI=";
  };

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    re2c
    lemon
  ];

  meta = {
    description = "Perplex is a scanner-generator that works with RE2C";
    homepage = "https://github.com/BRL-CAD/perplex";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
