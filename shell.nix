with import <nixpkgs> { };

stdenv.mkDerivation rec {
  name = "testix-dev-environment";

  buildInputs = [
    nixpkgs-fmt

    # https://testanything.org/consumers.html
    tappy
    tapview
  ];
}
