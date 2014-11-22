-module(sieve_of_sundaram).
-author("lethaljellybean@gmail.com").
-export([main/1]).
-import(lists, [seq/2, usort/1]).

%% @doc don't care about input
main(_) ->
  Max      = 100,
  Unwanted = usort(make_sequence(Max)),
  Wanted   = seq(1,Max) -- Unwanted,
  Final    = make_odd_primes(Wanted),
  io:format("~p~n", [Final]).

%% @doc according to the sieve, after w're done collecting the numbers we don't
%%   want,
make_odd_primes(L) ->
  [X * 2 + 1 || X <- L].

%% @doc calculate the unwanted numbers in the form of i + j + 2ij <= n
make_sequence(Max) ->
  [num_calc(X, Y) || X <- seq(1, Max),
                     Y <- seq(1, Max),
                     num_calc(X, Y) =< Max].

num_calc(X, Y) ->
  X + Y + 2 * X * Y.
