{
  buildVimPlugin,
  fetchFromGitHub,
  rustPlatform,
  ...
}: {
  gh-actions-nvim = let
    version = "2024-02-20";
    gh-actions-nvim-src = fetchFromGitHub {
      owner = "topaxi";
      repo = "gh-actions.nvim";
      rev = "4e19683aa581d8670d99e74104610a673f11964d";
      sha256 = "RivPNOv3P7fADBriDY4TyRMZJqISlabKFYJIxiQWXyc=";
    };
    gh-actions-nvim-bin = rustPlatform.buildRustPackage {
      pname = "gh-actions-nvim-bin";
      inherit version;
      src = gh-actions-nvim-src;

      cargoSha256 = "b546be4a5045d58a281bf10dee38982603f4d861dff09f1e6686c061f6f0a957";
    };
  in
    buildVimPlugin {
      pname = "gh-actions-nvim";
      inherit version;
      src = gh-actions-nvim-src;
      propagatedBuildInputs = [gh-actions-nvim-bin];
      preFixup = ''
        mkdir -p "$out/lua/deps/"
         cp "${gh-actions-nvim-bin}/target/release/libgh_actions_rust.dylib" "$out/lua/libgh_actions_rust.so" || true
         cp "${gh-actions-nvim-bin}/target/release/libgh_actions_rust.so" "$out/lua/libgh_actions_rust.so" || true
         cp "${gh-actions-nvim-bin}/target/release/deps/"*.rlib "$out/lua/deps/"
      '';
    };
}
