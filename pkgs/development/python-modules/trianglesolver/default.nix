{
  lib,
  buildPythonPackage,
  pythonOlder,
  python,
  fetchPypi,
}:
buildPythonPackage rec {
  pname = "trianglesolver";
  version = "1.2";
  pyproject = false; # manually installed

  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-SvGKreV51cDWQ4mz5lrq8Gz/JjGXYszYWeMmhVmnauo=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -D trianglesolver.py $out/${python.sitePackages}/trianglesolver.py

    runHook postInstall
  '';
}
