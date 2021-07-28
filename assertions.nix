with import ./lib.nix;

let
  statusFrom = result: if result then "ok" else "not ok";
  diagnosticFrom = result: value: expectation:
    if result then "" else "\n# Expected: ${toString_ expectation}\n# Got: ${toString_ value}";
in
{
  /*
    Type: assertEqual :: String -> String -> String

    Example:
    assertEqual true true "sanity check"
    => "ok - sanity check"
  */
  assertEqual = value: expectation: description:
    assert value != null && expectation != null && description != null;

    let
      result = value == expectation;
      status = statusFrom result;
      diagnostic = diagnosticFrom result value expectation;
    in
    "${status} - ${description}${diagnostic}";
}
