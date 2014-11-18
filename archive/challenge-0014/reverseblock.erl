-module(reverseblock).
-author("lethaljellybean@gmail.com").
-compile(export_all).

%% Solution for challenge 14, in erlang

%% @doc ARGS should first have an integer. Then a list. The integer specifies
%%   block size. Every block, we reverse that block.
main([]  ) -> reverseblock:help();
main(Args) ->
  [K | List] = sanitize_input(Args),
  pp(reverse_block(K, List)).

%% @doc guide the poor user
help() ->
  io:format("Usage:~n"),
  io:format("  reverseblock <chunksize> <element>+~n").

%% @doc Expect a list of integers in string form
sanitize_input(Input) -> 
  lists:map(fun(X) -> {K, _} = string:to_integer(X), K end, Input).

%% @doc Reverse each inner array
reverse_block(K, List) ->
  Arr = split_to_n(K, List),
  lists:map(fun(X) -> lists:reverse(X) end, Arr).
  
%% @doc this will split the list to blocks of K size
split_to_n(_, []  ) -> [];
split_to_n(K, List) when K > erlang:length(List) -> [List];
split_to_n(K, List) ->
  [lists:sublist(List, K)] 
  ++ split_to_n(K, lists:sublist(List, K+1, erlang:length(List))).

%% @doc for pretty printing
pp(List) ->
  Flat = lists:flatten(List),
  lists:map(fun(X) -> io:format("~p ", [X]) end, Flat),
  io:format("~n").
