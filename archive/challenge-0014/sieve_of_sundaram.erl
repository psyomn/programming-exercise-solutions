-module(sieve_of_sundaram).
-author("lethaljellybean@gmail.com").
-export([main/1]).
-import(lists, [seq/2, usort/1]).
-include_lib("eunit/include/eunit.hrl").

%% @doc don't care about input
main(_) ->
  Final = process(),
  io:format("~p~n", [Final]).

process() ->
  Max      = 100,
  Unwanted = usort(make_sequence(Max)),
  Wanted   = seq(1,Max) -- Unwanted,
  [2] ++ make_odd_primes(Wanted).

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

final_result_test_() ->
        Final = process(),
        ?_assert(Final =:= up_to_199()).

up_to_199() ->
  [2,    3,    5,    7,   11,   13,   17,   19,   23,   29,
    31,   37,   41,   43,   47,   53,   59,   61,   67,   71,
    73,   79,   83,   89,   97,  101,  103,  107,  109,  113,
   127,  131,  137,  139,  149,  151,  157,  163,  167,  173,
   179,  181,  191,  193,  197,  199].
