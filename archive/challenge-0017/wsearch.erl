-module(wsearch).
-author("lethaljellybean@gmail.com").
-export([main/1,request/1,contains_string/2]).

main([]) ->
  io:format("Usage:~n  wsearch <webpage> <sentence>~n");
main([Webpage,Sentence|_]) ->
  application:start(inets),
  io:format("Webpage to search on: ~p~n", [Webpage]),
  io:format("Term to look for:     ~p~n", [Sentence]),
  Body = request(Webpage),
  Found = contains_string(Body, Sentence),
  io:format("Website contains sentence: ~p~n", [Found]).

contains_string(Body, SearchPhrase) ->
  LowerBody = string:to_lower(Body),
  LowerPhrase = string:to_lower(SearchPhrase),
  case string:str(LowerBody, LowerPhrase) of
    0 -> false;
    _ -> true
  end.

%% @doc request webpage, and return body contents
request(Url) ->
  {ok, {{_Version, 200, _ReasonPhrase}, _Headers, Body}} = httpc:request(Url),
  Body.
