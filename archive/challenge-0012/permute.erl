-module(permute).
-author("lethaljellybean@gmail.com").
-compile(export_all).

main([])   -> print_usage();
main(ARGS) -> io:format("~p~n", [permute(ARGS)]).

print_usage() ->
  io:format("usage:~n"),
  io:format("  permute <element>+~n").

permute([]) -> [[]];
permute(L)  -> [[H|T] || H <- L, T <- permute(L -- [H])].
