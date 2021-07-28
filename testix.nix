with import ./lib.nix;

let
  /*
    From an attrset of the following format: `{ description = assertion }`,
    evaluate every `assertion description`, and returns the list of resulting values.
  */
  _evaluateTests = tests:
    builtins.attrValues (
      builtins.mapAttrs (description: assertion: assertion description) tests
    );
in
{
  assertions = import ./assertions.nix;

  /*
    Evaluates the tests, and returns an output in TAP format containing the results of the evaluation.
    Tests are given through an attrset, where keys are descriptions, and values are assertions.

    Type: runTests :: AttrSet -> [String]

    Example:
    runTests { "sanity check" = assertEqual true true; "other sanity check" = assertEqual true false; }
    => ''
    1..2
    ok - sanity check
    not ok - other sanity check
    ''
  */
  runTests = tests:
    let
      results = _evaluateTests tests;
      numberOfTests = builtins.length results;
    in
    if numberOfTests > 0
    then ''
      1..${builtins.toString numberOfTests}
      ${join results "\n"}
    ''
    else "😢 - Your test suite is desperatly empty.";
}
