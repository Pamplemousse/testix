# testix

A testing framework for Nix, written in Nix.

For those who that have parts of their codebases using nix as a "general purpose" programming language: to perform data treatment, write libraries and utility functions, etc.
Output respects the [TAP format specification](http://testanything.org/tap-specification.html).

Features:
* ~rich~ (not yet) Assertions;
* Output respecting the TAP format;
* Skip

TODO:
  - documentation
      - note that tests are not run in order (as attrset aren't ordered)
  - add to https://testanything.org/producers.html
  - more asserts:
      - `assertContains A B` (check if A is a substring of B)
  - niv install

## Usage

```nix
# test.nix
with import ./testix.nix;
with assertions;

let
tests = {
  "should pass" = assertEqual 1 1;
  "should not pass" = assertEqual 1 2;
};
in
  runTests tests
```

For demonstration purposes, we can print the outputted results, leveraging `nix-instantiate`, and pipe them to a [TAP consumer](http://testanything.org/consumers.html).

```bash
nix-instantiate --eval test.nix

echo -e "$(nix-instantiate --eval test.nix)" | tr -d \" | tappy
```

As `testix` is tested using itself, `tests/test_*.nix` provide other examples.


## Contribute

[TAP specification](http://testanything.org/tap-specification.html)

```bash

```
