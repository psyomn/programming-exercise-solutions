-module(mtsort).
-author("lethaljellybean@gmail.com").
-import(nice_chunk, [nice_chunk/2]).
-compile(export_all).
-define(NUMRANGE, 1000000).

%% @doc challenge 14, hard; make millions of numbers. Make thread, and sort the
%% numbers.

main(NumThreads) ->
  SanitizedArgs = sanitize(NumThreads),

  Data = make_random_list(),

  Chunked   = nice_chunk(SanitizedArgs, Data),
  Workers   = make_workers(SanitizedArgs),
  MasterPID = spawn(?MODULE, master_process, [SanitizedArgs, []]),
  merge(Workers, Chunked, MasterPID).

master_process(0,   Acc) ->
  io:format("Final answer is: ~p~n", [Acc]);
master_process(RespCount, Acc) ->
  receive
    L ->
      NewAcc = Acc ++ L,
      master_process(RespCount - 1, NewAcc)
  end.

%% @doc recursively merge, and assign workers to sort
merge(WorkerPIDs, Chunks, MasterPID) ->
  Workload = lists:zip(WorkerPIDs, Chunks),
  lists:map(fun(X) -> {W, C} = X, W ! {C, MasterPID} end, Workload).

%% @doc random number generation for testing with algorithm
make_random_list()   -> make_random_list(?NUMRANGE).
make_random_list(Size) ->
  lists:map(fun(_) -> random_num() end, lists:seq(1,Size)).

random_num() -> round(random:uniform() * 1000000).

%% @doc return a list of PIDs of spawned worker processes
make_workers(Num) when Num =:= 0 -> [];
make_workers(Num) ->
  [spawn(?MODULE, worker, []) | make_workers(Num - 1)].

print_workers(Workers) ->
  io:format("Workers: ~n"),
  lists:map(fun(X) -> io:format(" * ~p~n", [X]) end, Workers).

% @doc Sanitize input from command line. Min threads, 1.
sanitize(Args) when length(Args) =:= 0 -> 1;
sanitize(Args) ->
  [First|_] = Args,
  {K, _} = string:to_integer(First),
   K.

%% @doc basic worker process that sorts a list (in our case a segment of a
%% list).
worker() ->
  receive
    {List, Other} ->
      io:format("work received~n"),
      Sorted = lists:sort(List),
      Other  ! Sorted
  end.

