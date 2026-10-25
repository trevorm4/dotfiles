{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "pd2-trade";
  version = "0.10.16";

  src = fetchurl {
    url = "https://github.com/errolgr/pd2-trade/releases/download/app-v${version}/PD2.Trader_${version}_amd64.AppImage";
    hash = "sha256-RNaXRFajp037dC0EbuubEANlqdAmDmf20ac3rzTf92U=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 "${appimageContents}/PD2 Trader.desktop" $out/share/applications/pd2-trade.desktop
    substituteInPlace $out/share/applications/pd2-trade.desktop \
      --replace-fail 'Exec=pd2-trader-installer' 'Exec=pd2-trade' \
      --replace-fail 'Icon=pd2-trader-installer' 'Icon=pd2-trade'
    install -Dm444 "${appimageContents}/PD2 Trader.png" $out/share/icons/hicolor/256x256/apps/pd2-trade.png
  '';

  meta = {
    description = "Project Diablo 2 app for price checking";
    homepage = "https://github.com/errolgr/pd2-trade";
    license = lib.licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "pd2-trade";
  };
}
