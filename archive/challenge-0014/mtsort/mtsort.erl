-module(mtsort).
-author("lethaljellybean@gmail.com").
-compile(export_all).

%% @doc challenge 14, hard; make millions of numbers. Make thread, and sort the
%% numbers.

main(NumThreads) ->
  SanitizedArgs = sanitize(NumThreads),
  Data    = make_random_list(),

  Chunked     = n_chunks(Data, SanitizedArgs),
  MasterPID   = spawn(mtsort, master_process, [SanitizedArgs, []]),
  Workers     = make_workers(SanitizedArgs),
  print_workers(Workers),

  Workload    = lists:zip(Workers, Chunked),
  lists:map(fun(X) -> {W, C} = X, W ! {C, MasterPID} end, Workload).

master_process(0,   Acc) ->
  %% TODO merge logic should go here
  io:format("Final answer is: ~p~n", [Acc]);

master_process(RespCount, Acc) ->
  receive
    L ->
      NewAcc = Acc ++ L,
      master_process(RespCount - 1, NewAcc)
  end.

merge() -> todo.

process_each_chunk(ListChunks, WorkerPIDs) -> todo.

%% @doc random number generation for testing with algorithm
make_random_list()   -> make_random_list(30).
make_random_list(Size) ->
  lists:map(fun(_) -> random_num() end, lists:seq(1,Size)).

random_num() -> round(random:uniform() * 100).

%% @doc return a list of PIDs of spawned worker processes
make_workers(Num) when Num =:= 0 -> [];
make_workers(Num) ->
  [spawn(mtsort, worker, []) | make_workers(Num - 1)].

print_workers(Workers) ->
  io:format("Workers: ~n"),
  lists:map(fun(X) -> io:format(" * ~p~n", [X]) end, Workers).

% @doc Sanitize input from command line. Min threads, 1.
sanitize(Args) when erlang:length(Args) =:= 0 -> 1;
sanitize(Args) ->
  [First|_] = Args,
  {K, _} = string:to_integer(First),
  K.

%% @doc basic worker process that sorts a list (in our case a segment of a
%% list).
worker() ->
  receive
    {List, Other} ->
      Sorted = lists:sort(List),
      Other  ! Sorted
  end.

%% @doc split list L into N chunks
n_chunks([],_) -> [];
n_chunks(L, 1) -> [L]; %% NB: list in list
n_chunks(L, NumPartitions) ->
  ChunkSize = ceiling(erlang:length(L) / NumPartitions),
  n_chunks_by_size(L, ChunkSize).

n_chunks_by_size(L, ChunkSize) when length(L) =< ChunkSize -> [L];
n_chunks_by_size([], _)  -> [];
n_chunks_by_size(L, ChunkSize) ->
  [lists:sublist(L, 1, ChunkSize)] ++
  n_chunks_by_size(
    lists:sublist(L,
    ChunkSize + 1,
    erlang:length(L)),
    ChunkSize).

length_of_chunk(L, N) ->
  X = erlang:length(L) / N,
  round(X).

ceiling(X) ->
  T = erlang:trunc(X),
  case (X - T) of
    Neg when Neg < 0 -> T;
    Pos when Pos > 0 -> T + 1;
    _    -> T
  end.

