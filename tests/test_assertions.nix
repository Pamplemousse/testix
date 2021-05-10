with import ../testix.nix;

with import ../assertions.nix;

let
  tests = {
    "assertEqual returns an OK message containing the description when the two parameters are the same" =
      let
        description = "description";
        result = assertEqual 42 42 description;
        expectedResult = "ok - description";
      in
      assertEqual result expectedResult;

    "assertEqual returns a NOT OK message containing the description and a diagnostic when the two parameters are NOT the same" =
      let
        description = "description";
        result = assertEqual 43 42 description;
        expectedResult = "not ok - description";
      in
      assertEqual result expectedResult;

    "assertEqual returns an OK message containing the description when the two compared lists are the same" =
      let
        description = "description";
        result = assertEqual [ 42 ] [ 42 ] description;
        expectedResult = "ok - description";
      in
      assertEqual result expectedResult;

    "assertEqual returns a NOT OK message containing the description and a diagnostic when the two compared lists are NOT the same" =
      let
        description = "description";
        result = assertEqual [ 42 ] [ ] description;
        expectedResult = "not ok - description";
      in
      assertEqual result expectedResult;

    "assertEqual returns an OK message containing the description when the two compared attrsets are the same" =
      let
        description = "description";
        result = assertEqual { key = "value"; } { key = "value"; } description;
        expectedResult = "ok - description";
      in
      assertEqual result expectedResult;

    "assertEqual returns a NOT OK message containing the description and a diagnostic when the two compared attrsets are NOT the same" =
      let
        description = "description";
        result = assertEqual { key = "value"; } { } description;
        expectedResult = "not ok - description";
      in
      assertEqual result expectedResult;
  };
in
runTests tests
