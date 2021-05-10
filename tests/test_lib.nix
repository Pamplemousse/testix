with import ../testix.nix;
with assertions;

with import ../lib.nix;

let
  tests = {
    "join can concatenate a string from a list of strings" =
      let
        list = [ "a" "b" "c" ];
        result = join list "";
      in
      assertEqual result "abc";

    "join can concatenate a string from a list of strings and a separator character" =
      let
        list = [ "a" "b" "c" ];
        result = join list "-";
      in
      assertEqual result "a-b-c";
  };
in
runTests tests
