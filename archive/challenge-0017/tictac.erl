-module(tictac).
-author("lethaljellybean@gmail.com").
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

main(_) ->
  Board = ?MODULE:make_board(),
  BlankBoard = blankify_board(Board),
  tictac:step(BlankBoard, ongoing).

%% @doc main game loop
step(_,     x) -> io:format("Congratulations! You have won~n");
step(_,     o) -> io:format("You have lost the game~n");
step(Board, _) ->
  print_board(Board),
  {CoordX, _} = string:to_integer(io:get_line("X: ")),
  {CoordY, _} = string:to_integer(io:get_line("Y: ")),
  NewBoard = place(CoordX, CoordY, Board, x),
  EnemyBoard = enemy_turn(NewBoard),
  case is_winning_state(EnemyBoard) of
    {true, Who} -> step(EnemyBoard, Who);
    false -> step(EnemyBoard, ongoing)
  end.

make_board() -> array:new(9).

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

%% @doc check any winning combination
is_winning_state(Board) ->
  case has_winning_rows(Board) of
    {true, _, Who} -> {true,Who};
    {false, _, _}  ->
      case has_winning_columns(Board) of
        {true, _, Who} -> {true,Who};
        {false, _, _}  ->
          case has_winning_diagonals(Board) of
            {true,_,Who} -> {true, Who};
            {false, _, _}  -> false
          end
      end
  end.

has_winning_rows(Board) ->
  R1 = get_array_elements(Board, [0,1,2]),
  R2 = get_array_elements(Board, [3,4,5]),
  R3 = get_array_elements(Board, [6,7,8]),
  WR1 = all_same(R1) andalso hd(R1) /= b,
  WR2 = all_same(R2) andalso hd(R2) /= b,
  WR3 = all_same(R3) andalso hd(R3) /= b,
  case WR1 of
    true -> {true, 0, hd(R1)};
    false ->
      case WR2 of
        true -> {true, 1, hd(R2)};
        false ->
          case WR3 of
            true -> {true, 2, hd(R3)};
            false -> {false, -1, none}
          end
      end
  end.

%% @doc checks to see if there are winning columns in the tictac board
has_winning_columns(Board) ->
  C1 = get_array_elements(Board, [0,3,6]),
  C2 = get_array_elements(Board, [1,4,7]),
  C3 = get_array_elements(Board, [2,5,8]),
  [WC1, WC2, WC3] = lists:map(fun(X) -> tictac:all_same(X) andalso hd(X) /= b end, [C1, C2, C3]),
  case WC1 of
    true -> {true, 0, hd(C1)};
    false ->
      case WC2 of
        true -> {true, 1, hd(C2)};
        false ->
          case WC3 of
            true -> {true, 2, hd(C3)};
            false -> {false, -1, none}
          end
      end
  end.

has_winning_diagonals(Board) ->
  D1 = get_array_elements(Board, [0,4,8]),
  D2 = get_array_elements(Board, [2,4,6]),
  [WD1, WD2] =
  lists:map(fun(X) -> tictac:all_same(X) andalso hd(X) /= b end, [D1, D2]),
  case WD1 of
    true -> {true, 0, hd(D1)};
    false ->
      case WD2 of
        true -> {true, 1, hd(D2)};
        false -> {false, -1, none}
      end
  end.

%% @doc are all the elements equal to each other in a list?
all_same(List) ->
  [H|_] = List,
  Compare = lists:map(fun(X) -> X =:= H end, List),
  lists:all(fun(X) -> X =:= true end, Compare).

%% @doc give an array, and a list of indices, and return those elements.
get_array_elements(Array, IndexList) ->
  get_array_elements_back(Array, IndexList, []).

get_array_elements_back(_,     [],        Acc) -> Acc;
get_array_elements_back(Array, IndexList, Acc) ->
  [H|T] = IndexList,
  get_array_elements_back(Array, T, [array:get(H, Array)|Acc]).

%% @doc returns the coordinates of each blank space, eg: [1,2,3].
blank_coordinates(Board) ->
  L = array:to_list(Board),
  LSize = lists:seq(0,array:size(Board)-1),
  Zipped = lists:zip(L, LSize),
  OnlyBlanks = lists:filter(fun(X) -> {V,_} = X, V == b end, Zipped),
  Coordinates = lists:map(fun(X) -> {_,C} = X, C end, OnlyBlanks),
  Coordinates.

%% @doc given a board, and coordinates of blanks, check where is best to
%%   place the next 'o', and return a list of best options (coordinates).
%%   This needs to do two things:
%%     1. Check if by one placement, the game can be won
%%     2. If not the above, which is the next best placement
%%   Return a board with AI player's placement.
enemy_turn(Board) ->
  TriadL = two_of(Board, o),
  case [] =:= TriadL of
    false ->
      [H|_] = TriadL,
      [BlankCoord|_] = blank_coordinate_of_triad(Board, H),
      NewBoard = place(BlankCoord, 0, Board, o),
      NewBoard;

    true ->
      BlankCoords = best_blanks(Board),
      [Best|_] = BlankCoords,
      NewBoard = place(Best, 0, Board, o),
      NewBoard
  end.

best_blanks(Board) ->
  MapWeights = coordinate_weights(),
  BCoords = blank_coordinates(Board),
  WeightedCoords =
    lists:map(fun(X) -> {X, maps:get(X, MapWeights)} end, BCoords),
  Sorted =
    lists:sort(
      fun(A,B) -> {_,WA} = A,
                  {_,WB} = B,
                  WA > WB end, WeightedCoords),
  FinalCoords =
    lists:map(fun(X) -> {C,_} = X, C end, Sorted),
  FinalCoords.

%% @doc Player is the atom 'x' or 'o'. This checks which rows have two of those
%%   atoms and a blank in the middle.
%%   Returns a list of triads (as lists) which have two insertions.
two_of(Board, Player) ->
  R1 = [0,1,2],
  R2 = [3,4,5],
  R3 = [6,7,8],
  C1 = [0,3,6],
  C2 = [1,4,7],
  C3 = [2,5,8],
  D1 = [0,4,8],
  D2 = [2,4,6],
  Rows = [R1,R2,R3],
  Cols = [C1,C2,C3],
  Dias = [D1,D2],
  Occurences =
    lists:map(
      fun(X) -> {X, tictac:count_occurences(Player, X, Board)} end,
      Rows ++ Cols ++ Dias),
  TwoOcc =
    lists:filter(
      fun(X) -> {_,Count} = X, Count == 2 end,
      Occurences),
  TriadsOcc2 =
    lists:map(
      fun(X) -> {T,_} = X, T end, TwoOcc),
  TriadsOcc2.

%% Given a triad [0,1,2], get the coordinates which are blank.
blank_coordinate_of_triad(Board, Triad) ->
  E = get_array_elements(Board, Triad),
  EA = lists:zip(Triad, E),
  Blanks = lists:filter(
    fun(X) -> {_,C} = X, C == b end,
    EA),
  lists:map(
    fun(X) -> {C,_} = X, C end, Blanks).

count_occurences(Player, Triad, Board) ->
  E = lists:filter(
    fun(X) -> X =:= Player end,
    get_array_elements(Board, Triad)),
  Count = erlang:length(E),
  Count.

%% @doc get a data structure representing weights of blank coordinates
coordinate_weights() ->
  maps:from_list([
    % Rush for corners
    {0,3}, {2,3}, {6,3}, {8,3},
    % Kind of prefer center
    {4,2},
    % Rest
    {1,0},{3,0},{5,0},{7,0}
  ]).

%%% Tests

all_same_test() ->
  ?assert(all_same([1,1,1,1,1])),
  ?assert(all_same([b,b,b,b,b])),
  ?assert(false == all_same([x,x,o])),
  ?assert(false == all_same([x,b,b])).

get_array_elements_test() ->
  Array = array:new(5),
  A0 = array:set(0, b, Array),
  A1 = array:set(1, b, A0),
  A2 = array:set(2, b, A1),
  ?assert([b,b,b] == get_array_elements(A2, [0,1,2])).

has_winning_rows_test() ->
  Board = array:from_list([x,x,x,
                           b,o,b,
                           b,b,b]),

  Board2 = array:from_list([b,b,b,
                            x,x,x,
                            b,b,b]),

  Board3 = array:from_list([b,b,b,
                            b,b,b,
                            o,o,o]),

  Board4 = array:from_list([b,b,b,
                            b,b,b,
                            b,b,b]),

  ?assert({true,0,x} == has_winning_rows(Board)),
  ?assert({true,1,x} == has_winning_rows(Board2)),
  ?assert({true,2,o} == has_winning_rows(Board3)),
  ?assert({false,-1,none} == has_winning_rows(Board4)).

has_winning_columns_test() ->
  Board = array:from_list([x,x,b,
                           x,o,b,
                           x,b,b]),

  Board2 = array:from_list([b,x,b,
                            x,x,x,
                            b,x,b]),

  Board3 = array:from_list([b,b,o,
                            b,b,o,
                            o,o,o]),

  Board4 = array:from_list([b,b,b,
                            b,x,b,
                            x,b,b]),

  ?assert({false,-1,none} == has_winning_columns(Board4)),
  ?assert({true,0,x} == has_winning_columns(Board)),
  ?assert({true,1,x} == has_winning_columns(Board2)),
  ?assert({true,2,o} == has_winning_columns(Board3)).

has_winning_diagonals_test() ->
  Board = array:from_list([x,b,b,
                           b,x,b,
                           b,b,x]),

  Board2 = array:from_list([b,x,o,
                            x,o,x,
                            o,x,b]),

  Board3 = array:from_list([b,x,b,
                            x,x,x,
                            b,x,b]),

  ?assert({true,0,x} == has_winning_diagonals(Board)),
  ?assert({true,1,o} == has_winning_diagonals(Board2)),
  ?assert({false,-1,none} == has_winning_diagonals(Board3)).

blank_coordinates_test() ->
  Board = array:from_list([x,b,b,
                           b,x,b,
                           b,b,x]),
  Result = blank_coordinates(Board),
  ?assert([1,2,3,5,6,7] == Result).

count_occurences_test() ->
  Board = array:from_list([x,x,x,
                           b,b,b,
                           b,b,b]),
  ?assert(3 == count_occurences(x, [0,1,2], Board)).

two_of_test() ->
  Board1 = array:from_list([x,b,x,
                            b,b,b,
                            x,b,x]),
  Ret1 = two_of(Board1, x),
  Expected1 = [[0,1,2],[6,7,8],
               [0,3,6],[2,5,8],
               [0,4,8],[2,4,6]],

  Board2 = array:from_list([x,b,x,
                            b,b,b,
                            b,b,b]),
  Expected2 = [[0,1,2]],
  Ret2 = two_of(Board2, x),

  Board3 = array:from_list([o,b,b,
                            b,b,b,
                            b,b,o]),

  BoardMixed = array:from_list([o,b,x,
                                b,b,b,
                                o,b,x]),
  RetMixed = two_of(BoardMixed, o),
  ExpectedMixed = [[0,3,6]],

  Ret3 = two_of(Board3, o),
  Expected3 = [[0,4,8]],

  RetNoneFound = two_of(Board3, x),

  ?assert(Ret1         == Expected1),
  ?assert(Ret2         == Expected2),
  ?assert(Ret3         == Expected3),
  ?assert(RetNoneFound == []),
  ?assert(RetMixed     == ExpectedMixed).

best_blanks_test() ->
  Board = array:from_list([x,b,b,
                           b,b,b,
                           b,b,x]),
  Ret = best_blanks(Board),
  ?assert(Ret == [6,2,4,7,5,3,1]).

