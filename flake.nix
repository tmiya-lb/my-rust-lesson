{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs { inherit system overlays; };
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
                  buildInputs = [
                    rustToolchain
                    pkgs.gcc      # 明示的にgccを追加
                    pkgs.binutils # リンカ等を含む
                  ];

                  # これを追加することで、Rustに「ccはこれだよ」と教えます
                  shellHook = ''
                    export RUSTFLAGS="-C linker=${pkgs.gcc}/bin/gcc"
                  '';
                };
      }
    );
}
