{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  setuptools,
  setuptools_scm,
  svgpathtools,
  anytree,
  ezdxf,
  ipython,
  numpy,
}:
let
  ipython_ver = "8.37.0";
in
buildPythonPackage rec {
  pname = "build123d";
  version = "0.9.1";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "gumyr";
    repo = "build123d";
    tag = "v${version}";
    hash = "sha256-pOYK6zXC5z0JohL4k/NMI/ALfHVKSJM5eM2bLcyKhpQ=";
  };

  build-system = [
    setuptools
    setuptools_scm
  ];

  dependencies = [
    numpy
    svgpathtools
    anytree
    ezdxf
    ipython
  ];

  pythonRelaxDeps = [
    "ipython"
  ];

  meta = with lib; {
    homepage = "https://github.com/gumyr/build123d";
    description = "A python CAD programming library";
    license = licenses.asl20;
  };
}
