-module(spiral).
-author("lethaljellybean@gmail.com").
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

-record(board, {data,currpos,curdir=down}).

main(_) ->
  CycleEven = spiral:new(10),
  CycleOdd = spiral:new(11),
  io:format("10: ~p~n", [CycleEven]),
  io:format("11: ~p~n", [CycleOdd]).

directions() ->
  maps:from_list([{d, l}, {l, u}, {u, r}, {r, d}]).

new(N) ->
  M = directions(),
  L = spiral:spiral_directions(N),
  cyclezip(L, M, d).

board_set_coord(B, X, Y) ->
  B#board{data    = B#board.data,
          currpos = {X, Y},
          curdir  = B#board.curdir}.

board_set_curdir(B, Dir) ->
  B#board{data    = B#board.data,
          currpos = B#board.currpos,
          curdir  = Dir}.

board_set_data(B, Data) ->
  B#board{data    = Data,
          currpos = B#board.currpos,
          curdir  = B#board.curdir}.

%% @doc SpiralD are the directions zipped with the number sequence
spiral_array(SpiralD) ->
  %% N is the largest direction ie. size of array
  {N,_} = hd(SpiralD),
  A = array:new(N*N),
  Board = #board{data=A, currpos={0,N-1}, curdir=down}.

make_line(Board,      []) -> Board;
make_line(Board, SpiralD) ->
  CurPos = Board#board.currpos,
  case Board#board.curdir of
    u -> todo;
    d -> todo;
    l -> todo;
    r -> todo
  end.

spiral_directions(N) when N rem 2 == 0 ->
  L = lists:reverse(lists:seq(3,N-1,2)),
  [N] ++ spiral:repeat(L) ++ [1];
spiral_directions(N) when N rem 2 == 1 ->
  L = lists:reverse(lists:seq(2,N-1,2)),
  [N] ++ spiral:repeat(L).

repeat([]) -> [];
repeat([H|T]) ->
  [H,H] ++ repeat(T).

cyclezip([], _, _) -> [];
cyclezip([H|T], M, CurrDir) ->
  NextDir = maps:get(CurrDir, M),
  [{H,CurrDir}] ++ cyclezip(T, M, NextDir).

%%% Test

repeat_test() ->
  ?assert([1,1,2,2] == repeat([1,2])).

new_test() ->
  %% NB: Even and odd numbers given yield different endings in the sequences.
  %%   This is the reason you will see both of those tests listed here.
  ?assert([{10,d}, {9,l}, {9,u}, {7,r}, {7,d},
           {5,l}, {5,u}, {3,r}, {3,d}, {1,l}]
          ==
          spiral:new(10)),

  ?assert([{11,d}, {10,l}, {10,u}, {8,r}, {8,d},
           {6,l}, {6,u}, {4,r}, {4,d}, {2,l}, {2,u}]
          ==
          spiral:new(11)).

board_set_coord_test() ->
  B = #board{data=array:new(10), currpos={1,1}, curdir=d},
  C = board_set_coord(B, 4, 4),
  ?assert(C#board.currpos == {4, 4}).

board_set_curdir_test() ->
  B = #board{data=array:new(10), currpos={1,1}, curdir=d},
  C = board_set_curdir(B, l),
  ?assert(C#board.curdir == l).

board_set_data_test() ->
  B = #board{data=array:set(3,3, array:new(10)), currpos={1,1}, curdir=d},
  C = board_set_data(B, array:set(4,4,array:new(11))),
  ?assert(B#board.data == array:set(3,3,array:new(10))),
  ?assert(C#board.data    == array:set(4,4,array:new(11))),
  ?assert(C#board.currpos == B#board.currpos),
  ?assert(C#board.curdir  == B#board.curdir).

