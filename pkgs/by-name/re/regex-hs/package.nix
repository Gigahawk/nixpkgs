{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation {
  pname = "regex-hs";
  version = "0-unstable-2023-09-16";

  src = fetchFromGitHub {
    owner = "BRL-CAD";
    repo = "regex";
    rev = "d26a6f727005adf483c84e95b838ac1c7980fea8";
    hash = "sha256-OFDLbz9BogFeAKmEANo9qNtYmfOQ1WoqhSnGer8NFbQ=";
  };

  nativeBuildInputs = [
    cmake
  ];

  #  env.NIX_CFLAGS_COMPILE = toString [
  #    "-std=gnu89"
  #  ];

  meta = {
    description = "The Henry Spencer regex library";
    homepage = "https://github.com/BRL-CAD/regex";
    license = lib.licenses.free;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
