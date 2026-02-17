{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation rec {
  pname = "stepcode";
  version = "0.8.2";

  src = fetchFromGitHub {
    owner = "stepcode";
    repo = "stepcode";
    tag = "v${version}";
    hash = "sha256-9tfAns+33qmbOeK3C5tuwiSEuqSwSvworWIEpXMKIeI=";
  };

  nativeBuildInputs = [
    cmake
  ];

  env.NIX_CFLAGS_COMPILE = toString [
    "-D_POSIX_C_SOURCE=200809L"
  ];

  meta = {
    description = "Data Exchange with ISO 10303";
    homepage = "https://stepcode.github.io/";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ gigahawk ];
    platforms = lib.platforms.all;
  };
}
