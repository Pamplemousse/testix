with import ./lib.nix;

let
  statusFrom = result: if result then "ok" else "not ok";
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
    in
    "${status} - ${description}";
}
