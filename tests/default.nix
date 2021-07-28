with import <nixpkgs> { };

with import ../testix.nix;

let
  allTestFiles = [ ./test_assertions.nix ./test_lib.nix ];
  allTests = builtins.foldl' (acc: f: acc // (import f)) allTestFiles [];
in
stdenv.mkDerivation {
  name = "allTestsResults";
  src = allTests "";

  dontUnpack = true;
  dontInstall = true;
  dontCheck = true;

  buildPhase = ''
    mkdir -p $out
    echo "${runTests allTests}" > $out/results
  '';
}
