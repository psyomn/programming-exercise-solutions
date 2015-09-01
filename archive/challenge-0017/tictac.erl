-module(tictac).
-author("lethaljellybean@gmail.com").
-export([main/1]).

make_board() ->
  [[b,b,b],
   [b,b,b],
   [b,b,b]].

main(_) ->
  Board = make_board(),
  step(Board),
  io:format("Bye.~n").

step(Board) ->
  step(Board).

place(_Board, _X, _Y, V) when V /= x andalso V /= o ->
  throw(not_x_or_o);
place(Board, X, Y, V) ->
  ToEdit = lists:nth(Y, Board).

