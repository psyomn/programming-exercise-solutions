-module(stars).
-author("lethaljellybean@gmail.com").
-export([main/1, star/1]).

%% write an application which will print a triangle of stars of user-specified
%% height, with each line having twice as many stars as the last. sample output:
%%
%% @
%%
%% @@
%%
%% @@@@
%%
%% hint: in many languages, the "+" sign concatenates strings.
%%
%% bonus features: print the triangle in reverse, print the triangle right
%% justified

main([]) ->
  io:format("Usage:~n  stars.erl <normal|rev|ralign> <number>~n");
main([OrderOption,CountString|_]) ->
  {CountNum, _Rest} = string:to_integer(CountString),
  case OrderOption of
    "normal" -> star(CountNum);
    "rev" -> starrev(CountNum);
    "ralign" -> io:format("Todo")
  end.

star(X) ->
  star_backend(1, X).

starrev(1) ->
  draw_row(1);
starrev(X) ->
  draw_row(X),
  starrev(X - 1).

star_backend(From, To) when From > To ->
  throw(from_not_smaller_than_to);
star_backend(V, V) ->
  draw_row(V);
star_backend(From, To) ->
  draw_row(From),
  star_backend(From + 1, To).

draw_row(0) ->
  throw(dont_use_zero);
draw_row(1) ->
  io:format("@~n");
draw_row(X) ->
  io:format("@"),
  draw_row(X - 1).

