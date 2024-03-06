{
  pkgs,
  unzip,
}:
pkgs.stdenv.mkDerivation rec {
  pname = "maple-mono-nf";
  version = "v7.0-beta8";
  src = builtins.fetchurl {
    url = "https://github.com/subframe7536/maple-font/releases/download/${version}/MapleMono-nf.zip";
    sha256 = "08a1q6dfxmb259wd80aqnkabb24yaf25a12dcf6pik9n9rmxg5b5";
  };
  nativeBuildInputs = [unzip];
  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    install -Dm64 *.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
