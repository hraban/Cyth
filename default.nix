{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) lib;
in

pkgs.stdenv.mkDerivation (old: {
  __structuredAttrs = true;
  strictDeps = true;

  name = "cyth";
  nativeBuildInputs = with pkgs; (
    [ cmake ]
    ++ lib.optionals old.doCheck [ nodejs ]
  );
  doCheck = true;
  cmakeFlags = lib.optionals old.cythWasm [
    "-DWASM=1"
  ];
  src = lib.cleanSource ./.;

  cythWasm = false;
})
