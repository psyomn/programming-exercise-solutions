-module(nice_chunk).
-author("lethaljellybean@gmail.com").
-compile(export_all).

%% @doc helper to break a list into n chunks. If the list divides nicely, then
%%   we can go on with our lives. If not, then we do extra calculations for the
%%   remainder of elements (eg 10 mode 3 = 1, so last list will contain 4
%%   elements instead of 3)
nice_chunk(Partitions, _   ) when Partitions   < 1 -> [];
nice_chunk(Partitions, List) when Partitions =:= 1 -> List;
nice_chunk(Partitions, List) ->
  PSize  = trunc(length(List) / Partitions),
  Chunks = nice_chunk:nice_chunk_b(PSize, List),
  attach_remainder(Chunks).

%% @doc PSize is the best amount of elements per partition. If there is a
%%   remainder, it is appended to the tail element.
nice_chunk_b(    _, []  ) -> [];
nice_chunk_b(PSize, List) ->
  Chunk = lists:sublist(List, 1, PSize),
  Rest  = rest_or_empty(List, PSize + 1, length(List)),
  [Chunk | nice_chunk_b(PSize, Rest)].

rest_or_empty(L, From, To) when From > length(L) -> [];
rest_or_empty(L, From, To) ->
  lists:sublist(L, From, To).

%% @doc if the remainder
attach_remainder(L) ->
  Last        = lists:last(L),
  [First | _] = L,
  case length(Last) =:= length(First) of
    true  ->
      L;

    false ->
      WithoutLast     = lists:droplast(L),
      WithoutLastLast = lists:droplast(WithoutLast),
      ToCombine       = lists:last(WithoutLast),
      WithoutLastLast ++ [ToCombine ++ Last]

  end.
