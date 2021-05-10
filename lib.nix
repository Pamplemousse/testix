let
  /*
    Type: join :: [String] -> String -> String

    Example:
    join [ "a" "b" "c" ] "-"
    => "a-b-c"
  */
  join = l: separator:
    let
      result = builtins.foldl'
        (
          acc: x:
            {
              content = if acc.counter == 0 then x else acc.content + separator + x;
              counter = acc.counter + 1;
            }
        )
        { content = ""; counter = 0; }
        l;
    in
    result.content;
in
{
  inherit join;
}
