{
  lib,
  asar,
  electron,
  fetchurl,
  makeWrapper,
  stdenv,
  unzip,
}:

stdenv.mkDerivation {
  pname = "etor";
  version = "1.2.0";

  src = fetchurl {
    url = "https://github.com/Giboork/TLI-tracker-translated/releases/download/v1.2.0/TLI-tracker-translated-v1.2.0.zip";
    hash = "sha256-5GDTCeQg1+c3UzQpuItRz6XT6BxFvZ7sPpRgHQ1A+xU=";
  };

  nativeBuildInputs = [
    asar
    makeWrapper
    unzip
  ];

  # The release is a Windows Electron build; only resources/app.asar is usable.
  unpackPhase = ''
    runHook preUnpack

    unzip -q "$src" 'resources\\app.asar' -d "$NIX_BUILD_TOP/unpacked" || true
    asar extract "$NIX_BUILD_TOP/unpacked/resources/app.asar" app

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/etor
    cp -r app/. $out/share/etor/

    mkdir -p $out/bin
    makeWrapper ${electron}/bin/electron $out/bin/etor \
      --add-flags $out/share/etor \
      --add-flags "--no-sandbox" \
      --add-flags "--disable-dev-shm-usage" \
      --add-flags "\''${NIXOS_OZONE_WL:+-enable-features=UseOzonePlatform -ozone-platform=wayland}" \
      --set-default ELECTRON_IS_DEV 0 \
      --set-default NODE_ENV production \
      --run "cd $out/share/etor"

    mkdir -p $out/share/applications
    cat > $out/share/applications/etor.desktop << EOF
    [Desktop Entry]
    Name=ETor
    Comment=易火-ETor - Torchlight Infinite tracking tool
    Exec=$out/bin/etor
    Icon=etor
    Type=Application
    Categories=Utility;
    Terminal=false
    EOF

    mkdir -p $out/share/icons/hicolor/256x256/apps
    cp $out/share/etor/etor.png $out/share/icons/hicolor/256x256/apps/etor.png

    runHook postInstall
  '';

  meta = {
    description = "易火-ETor - Torchlight Infinite tracking tool (English translation)";
    homepage = "https://github.com/Giboork/TLI-tracker-translated";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "etor";
  };
}
