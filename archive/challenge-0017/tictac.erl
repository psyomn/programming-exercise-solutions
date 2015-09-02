-module(tictac).
-author("lethaljellybean@gmail.com").
-export([main/1]).

main(_) ->
  Board = make_board(),
  BlankBoard = blankify_board(Board),
  XBoard = place(1,1,BlankBoard,x),
  print_board(XBoard).

make_board() ->
  array:new(9).

blankify_board(Board) ->
  Size = array:size(Board),
  blankify_board_back(Board, Size - 1).

blankify_board_back(Board, -1) -> Board;
blankify_board_back(Board, Size) ->
  BNew = array:set(Size, b, Board),
  blankify_board_back(BNew, Size - 1).

print_board(Board) ->
  print_board_back(Board, 0, array:size(Board)).

print_board_back(_,     Max, Max) -> ok;
print_board_back(Board, From, To) ->
  io:format("~p ", [array:get(From, Board)]),
  case (From + 1) rem 3 == 0 of
    true -> io:format("~n");
    false -> skip
  end,
  print_board_back(Board, From + 1, To).

place(X, Y, Board, V) ->
  array:set(Y * 3 + X, V, Board).

get_at(X, Y, Board) ->
  array:get(Y * 3 + X, Board).
