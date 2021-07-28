let
  _attrsToString = attrs:
    assert builtins.isAttrs attrs;
    let
      first = xs: builtins.elemAt xs 0;
      second = xs: builtins.elemAt xs 1;

      keys = builtins.attrNames attrs;
      values = builtins.attrValues attrs;

      content = join (builtins.map (kv: "${first kv} = ${toString_ (second kv)};") (zip keys values)) "\n";
    in
    if (builtins.length keys) == 0
    then "{ }"
    else "{ ${content} }";

  _listToString = list:
    assert builtins.isList list;
    if builtins.length list == 0
    then "[ ]"
    else "[ ${join (builtins.map toString_ list) " "} ]";

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

  /*
    Type: toString_ :: a -> String

    Example:
    toString_ [ "a" "b" "c" ]
    => "[ \"a\" \"b\" \"c\" ]"

    toString_ { key = "value"; }
    => "{ key = \"value\"; }"
  */
  toString_ = x:
    if (builtins.isString x)
    then "\"${x}\""
    else
      if (builtins.isAttrs x)
      then _attrsToString x
      else
        if (builtins.isList x)
        then _listToString x
        else builtins.toString x;

  /*
    Type: zip :: [a] -> [a] -> [[a]]

    Example:
    zip [ "a" "b" "c" ] [ 1 2 3 ]
    => [ [ "a" 1 ] [ "b" 2 ] [ "c" 3 ] ]
  */
  zip = list1: list2:
    let
      length = builtins.length list1;
    in
    assert (builtins.isList list1) && (builtins.isList list2);
    assert length == builtins.length list2;
    builtins.genList (n: [ (builtins.elemAt list1 n) (builtins.elemAt list2 n) ]) length;
in
{
  inherit join toString_ zip;
}
