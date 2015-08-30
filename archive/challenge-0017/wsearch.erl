-module(wsearch).
-author("lethaljellybean@gmail.com").
-export([main/1,request/1]).

main([]) ->
  io:format("Usage:~n  wsearch <webpage> <sentence>~n");
main([Webpage,Sentence|_]) ->
  io:format("Webpage to search on: ~p", [Webpage]),
  io:format("Term to look for:     ~p", [Sentence]),
  request(Webpage).

request(Url) ->
  {ok, {{Version, 200, ReasonPhrase}, Headers, Body}} = httpc:request(Url),
  io:format("~p~n", [Body]).
