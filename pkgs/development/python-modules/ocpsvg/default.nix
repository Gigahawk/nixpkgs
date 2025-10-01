{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  setuptools_scm,
  svgelements,
}:
buildPythonPackage rec {
  pname = "ocpsvg";
  version = "0.5.0";
  pyproject = true;

  src = fetchFromGitHub {
    repo = pname;
    tag = version;
    owner = "snoyer";
    hash = "sha256-DUgnIiju5SRDbCZd5Tf3vWXl70SLtag4Bi5Bd3AzKIc=";
  };

  build-system = [
    setuptools
    setuptools_scm
  ];

  dependencies = [
    svgelements
  ];

}
