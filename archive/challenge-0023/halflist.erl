-module(halflist).
-export([main/1]).

main(_) ->
  L1 = lists:seq(1, 6),
  L2 = lists:seq(1, 11),
  Even = lists:split(trunc(erlang:length(L1) / 2), L1),
  Odd = lists:split(trunc(erlang:length(L2) / 2), L2),
  io:format("Even: ~p~n", [Even]),
  io:format("Odd : ~p~n", [Odd]).
