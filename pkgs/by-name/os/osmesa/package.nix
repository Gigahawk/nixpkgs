{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "osmesa";
  version = "0-unstable-2026-01-16";

  src = fetchFromGitHub {
    owner = "starseeker";
    repo = "osmesa";
    rev = "af465ac40d8727ebf04837bd5b2e5df084b7b237";
    hash = "sha256-Wr6xGvASRkuU25iGfVrd51hvDC8WmQclYxhqxPY7toI=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = {
    description = "Library providing Mesa3d 7.0.4 swrast and osmesa capabilities.";
    homepage = "https://github.com/starseeker/osmesa";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
