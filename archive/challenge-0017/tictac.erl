-module(tictac).
-author("lethaljellybean@gmail.com").
-export([main/1]).

-include_lib("eunit/include/eunit.hrl").

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

is_winning_state(Board) ->
  [has_winning_rows(Board),
   has_winning_columns(Board),
   has_winning_diagonals(Board)].

has_winning_rows(Board) ->
  R1 = get_array_elements(Board, [0,1,2]),
  R2 = get_array_elements(Board, [3,4,5]),
  R3 = get_array_elements(Board, [6,7,8]),
  WR1 = all_same(R1),
  WR2 = all_same(R2),
  WR3 = all_same(R3),
  case WR1 of
    true -> {true, 0, hd(R1)};
    false ->
      case WR2 of
        true -> {true, 1, hd(R2)};
        false ->
          case WR3 of
            true -> {true, 2, hd(R3)};
            false -> false
          end
      end
  end.

has_winning_columns(Board) -> true.
has_winning_diagonals(Board) -> true.

all_same(List) ->
  [H|_] = List,
  Compare = lists:map(fun(X) -> X == H end, List),
  lists:foldl(fun(X,Sum) -> Sum == X end, true, Compare).

get_array_elements(Array, IndexList) ->
  get_array_elements_back(Array, IndexList, []).

get_array_elements_back(_,     [],        Acc) -> Acc;
get_array_elements_back(Array, IndexList, Acc) ->
  [H|T] = IndexList,
  get_array_elements_back(Array, T, [array:get(H, Array)|Acc]).

%%% Tests

all_same_test() ->
  ?assert(
    true  == all_same([1,1,1,1,1]) andalso
    true  == all_same([b,b,b,b,b]) andalso
    false == all_same([x,x,o])).

get_array_elements_test() ->
  Array = array:new(5),
  A0 = array:set(0, b, Array),
  A1 = array:set(1, b, A0),
  A2 = array:set(2, b, A1),
  ?assert([b,b,b] == get_array_elements(A2, [0,1,2])).

has_winning_rows_test() ->
  Board = array:from_list([x,x,x,b,o,b,b,b,b]),
  Board2 = array:from_list([b,b,b,x,x,x,b,b,b]),
  Board3 = array:from_list([b,b,b,b,b,b,o,o,o]),
  has_winning_rows(Board),
  has_winning_rows(Board2),
  has_winning_rows(Board3).

