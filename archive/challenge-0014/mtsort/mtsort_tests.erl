-module(mtsort_tests).
-import(mtsort, [n_chunks/2]).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

make_test_list() -> lists:seq(1,10).

n_chunks_test_() ->
        L = make_test_list(),
        [?_assert(length(n_chunks(L, 1)) =:= 1),
         ?_assert(length(n_chunks(L, 2)) =:= 2),
         ?_assert(length(n_chunks(L, 3)) =:= 3),
         ?_assert(length(n_chunks(L, 4)) =:= 4)
        ].

with_2_head_test() ->
        L      = make_test_list(),
        Chunks = n_chunks(L, 2),
        io:format("~p~n", [Chunks]),
        [H|_] = Chunks,
        ?_assert(H =:= [1,2,3,4,5]).

with_3_head_test() ->
        L      = make_test_list(),
        Chunks = n_chunks(L, 3),
        [H|_] = Chunks,
        ?_assert(H =:= [1,2,3]).

with_2_tail_test() ->
        L = make_test_list(),
        Chunks = n_chunks(L, 2),
        ?_assert(lists:last(Chunks) =:= [6,7,8,9,10]).

with_3_tail_test() ->
        L = make_test_list(),
        Chunks = n_chunks(L, 3),
        ?_assert(lists:last(Chunks) =:= [10]).
