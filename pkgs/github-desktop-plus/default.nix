{
  stdenvNoCC,
  lib,
  fetchurl,
  autoPatchelfHook,
  buildPackages,
  gnome-keyring,
  libsecret,
  git,
  curlWithGnuTls,
  nss,
  nspr,
  xorg,
  libdrm,
  alsa-lib,
  cups,
  libgbm,
  systemdLibs,
  openssl,
  libglvnd,
  zstd,
}: let
  pkgver = "3.5.4";
in
  stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "github-desktop-plus";
    version = pkgver;

    src = let
      urls = {
        "x86_64-linux" = {
          url = "https://github.com/pol-rivero/github-desktop-plus/releases/download/v${pkgver}/GitHubDesktopPlus-v${pkgver}-linux-x86_64.deb";
          sha256 = "eef5a02a1fc82e9eeea1069aadab1898e36bcf3cc00320541fdb900a33f56e67";
        };
        "aarch64-linux" = {
          url = "https://github.com/pol-rivero/github-desktop-plus/releases/download/v${pkgver}/GitHubDesktopPlus-v${pkgver}-linux-arm64.deb";
          sha256 = "d77809dfa8abb41497a7eb1fbed9c1e5850b08cf0bcbe5e63d6b736154892a08";
        };
        "armv7l-linux" = {
          url = "https://github.com/pol-rivero/github-desktop-plus/releases/download/v${pkgver}/GitHubDesktopPlus-v${pkgver}-linux-armhf.deb";
          sha256 = "6370ebeb31b4285f3eb095b12f3076c726f6b81ec6d08224d94176086c333233";
        };
      };
    in
      fetchurl
      urls."${stdenvNoCC.hostPlatform.system}"
        or (throw "Unsupported system: ${stdenvNoCC.hostPlatform.system}");

    nativeBuildInputs = [
      autoPatchelfHook
      zstd
      (buildPackages.wrapGAppsHook3.override {makeWrapper = buildPackages.makeShellWrapper;})
    ];

    buildInputs = [
      gnome-keyring
      xorg.libXdamage
      xorg.libX11
      xorg.libXScrnSaver
      libsecret
      git
      curlWithGnuTls
      nss
      nspr
      libdrm
      alsa-lib
      cups
      libgbm
      openssl
    ];

    unpackPhase = ''
      runHook preUnpack
      mkdir -p $TMP/github-desktop-plus
      cp $src $TMP/github-desktop-plus.deb
      cd $TMP/github-desktop-plus
      ar x ../github-desktop-plus.deb
      tar --no-same-owner --no-same-permissions -xf data.tar.* || true
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/{opt,bin,share}
      cp -R usr/share $out/
      mkdir -p $out/opt/github-desktop-plus
      cp -R usr/lib/github-desktop-plus/* $out/opt/github-desktop-plus/
      ln -s $out/opt/github-desktop-plus/github-desktop-plus $out/bin/github-desktop-plus
      ln -s $out/opt/github-desktop-plus/resources/app/static/github $out/bin/github-desktop-plus-cli
      runHook postInstall
    '';

    preFixup = ''
      gappsWrapperArgs+=(
        --add-flags "\''${NIXOS_OZONE_WL:+\''${WAYLAND_DISPLAY:+--ozone-platform=wayland --enable-wayland-ime=true}}"
        --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [libglvnd]}
      )
    '';

    runtimeDependencies = [
      systemdLibs
    ];

    meta = with lib; {
      description = "Fork of GitHub Desktop with extra features and improvements";
      homepage = "https://github.com/pol-rivero/github-desktop-plus";
      license = licenses.mit;
      mainProgram = "github-desktop-plus";
      platforms = platforms.linux;
      sourceProvenance = with sourceTypes; [binaryNativeCode];
    };
  })
