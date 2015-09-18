-module(deadfish).
-author("lethaljellybean@gmail.com").
-export([main/1,execute/2]).

main([]) ->
  io:format("Usage~n  deadfish-erl [idos]+~n");
main([Input|_]) ->
  execute(Input, 0).

execute([],    Acc) -> Acc;
execute([H|T], Acc) ->
  case H of
    $i -> execute(T, Acc + 1);
    $d -> execute(T, Acc - 1);
    $s -> execute(T, Acc * Acc);
    $o -> io:format("~c", [Acc]);
    _   -> execute(T, Acc)
  end.
