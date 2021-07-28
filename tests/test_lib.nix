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

    "toString_ returns a string representation for bool, ints, floats, strings" =
      let
        result = builtins.map toString_ [ true 42 42.0 "forty-two" ];
      in
      assertEqual result [ "1" "42" "42.000000" "\"forty-two\"" ];

    "toString_ returns a string representation for lists" =
      let
        result = toString_ [ 42 43 ];
      in
      assertEqual result "[ 42 43 ]";

    "toString_ returns a string representation for nested lists" =
      let
        aList = [ 41 43 ];
        result = toString_ [ 42 aList ];
      in
      assertEqual result "[ 42 [ 41 43 ] ]";

    "toString_ returns a string representation for empty lists" =
      let
        result = toString_ [ ];
      in
      assertEqual result "[ ]";

    "toString_ returns a string representation for attrsets" =
      let
        result = toString_ { key = "value"; };
      in
      assertEqual result "{ key = \"value\"; }";

    "toString_ returns a string representation for nested attrsets" =
      let
        result = toString_ { key.nestedKey = "value"; };
      in
      assertEqual result "{ key = { nestedKey = \"value\"; }; }";

    "toString_ returns a string representation for empty attrsets" =
      let
        result = toString_ { };
      in
      assertEqual result "{ }";

    "zip can zip two lists of the same length together" =
      let
        list1 = [ "a" "b" "c" ];
        list2 = [ 1 2 3 ];
        result = zip list1 list2;
      in
      assertEqual result [ [ "a" 1 ] [ "b" 2 ] [ "c" 3 ] ];
  };
in
runTests tests
