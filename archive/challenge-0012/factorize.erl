-module(factorize).
-author("lethaljellybean@gmail.com").
-export([main/1]).

print_usage() ->
  io:format("usage:~n  factorize <number>~n").

sanitize(ARGS) ->
  [H|_] = ARGS,
  {N,_} = string:to_integer(H),
   N.

main([])   -> print_usage();
main(ARGS) ->
  Number = sanitize(ARGS),
  io:format("~p~n", [factorize(Number, 2)]).

factorize(1,     _) -> [];
factorize(Num, Div) ->
  case Num rem Div of
    0 -> [Div|factorize(Num div Div, Div)];
    _ -> factorize(Num, Div + 1)
  end.

