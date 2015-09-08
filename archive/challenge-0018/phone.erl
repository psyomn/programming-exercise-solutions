-module(phone).
-author("lethaljellybean@gmail.com").
-export([main/1,convert/1,c2nmap/0]).

main([]) ->
  io:format("Usage~n  phone.erl <phone-number>");
main([Phone|_]) ->
  Result = lists:map(fun(C) -> phone:convert(C) end, Phone),
  io:format("~s~n", [Result]).


convert(C) when C >= 65,
                C =< 90;
                C >= 97,
                C =< 122 ->
  M = phone:c2nmap(),
  maps:get(C, M);
% C is a number
convert(C) -> C.

c2nmap() ->
  Alphabet = lists:seq($A, $Z),
  MiniAlpha = lists:seq($A, $Z),
  Nums   = [2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,7,8,8,8,9,9,9,9],
  NumSeq = lists:map(fun(X) -> X + 48 end, Nums),
  Dial = lists:zip(Alphabet,NumSeq) ++ lists:zip(MiniAlpha,NumSeq),
  maps:from_list(Dial).
