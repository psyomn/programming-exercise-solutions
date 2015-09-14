-module(spiral).
-author("lethaljellybean@gmail.com").
-compile(export_all).

main(_) ->
  M = directions(),
  Even = spiral:spiral_directions(10),
  Odd  = spiral:spiral_directions(11),
  CycleEven = cyclezip(Even, M, d),
  CycleOdd  = cyclezip(Odd,  M, d),
  io:format("10: ~p~n", [CycleEven]),
  io:format("11: ~p~n", [CycleOdd]).

directions() ->
  maps:from_list([{d, l}, {l, u}, {u, r}, {r, d}]).

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

