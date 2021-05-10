with import ../testix.nix;
with assertions;

let
  tests = {
    "empty test suite returns an error message" = assertEqual (runTests {}) "😢 - Your test suite is desperatly empty.";
    "given test suite runs" =
    let
      aTestSuite = {
        "first test" = assertEqual 1 1;
        "second test" = assertEqual "a" "b";
      };
    in
      assertEqual (runTests aTestSuite) "1..2\nok - first test\nnot ok - second test\n";
  };
in
runTests tests
