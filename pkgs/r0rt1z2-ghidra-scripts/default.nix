{
  lib,
  fetchFromGitHub,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation {
  pname = "r0rt1z2-ghidra-scripts";
  version = "2026-04-11-unstable";

  src = fetchFromGitHub {
    owner = "R0rt1z2";
    repo = "ghidra-scripts";
    rev = "4c13df608842ecd80d5821f39d357e80eb8d38cc";
    hash = "sha256-lqi465fFkbzL213/aY8P3RmYEDxnIs4pvtpzO6XpHGk=";
  };

  installPhase = ''
    runHook preInstall

    GHIDRA_HOME=$out/lib/ghidra/Ghidra/Extensions/r0rt1z2-ghidra-scripts
    mkdir -p $GHIDRA_HOME
    cp -r . $GHIDRA_HOME/ghidra_scripts

    touch $GHIDRA_HOME/Module.manifest
    cat <<'EOF' > extension.properties
    name=r0rt1z2-ghidra-scripts
    description=Personal collection of Ghidra scripts by R0rt1z2.
    author=R0rt1z2
    createdOn=
    version=

    EOF

    runHook postInstall
  '';

  meta = {
    description = "Personal collection of Ghidra scripts by R0rt1z2.";
    homepage = "https://github.com/R0rt1z2/ghidra-scripts";
    license = lib.licenses.gpl3;
  };
}
