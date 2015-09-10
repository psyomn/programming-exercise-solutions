-module(formmaker).
-author("lethaljellybean@gmail.com").
-export([main/1]).

-include_lib("eunit/include/eunit.hrl").

main([]) ->
  io:format("Usage:~n  formmaker <filename>~n");
main([FileName|_]) ->
  case file:read_file(FileName) of
    {ok, Binary} -> 
      S = erlang:binary_to_list(Binary),
      T = formmaker:parse(S),
      P = formmaker:process_html_form(T);
    {error, enoent} ->
      io:format("No such file or directory~n");
    {error, Reason} ->
      io:format("~s~n", [Reason])
  end.

parse(String) -> todo.

%% @doc this gets the label of the question. Return {LabelName, Rest}
parse_name([]   , Acc) -> {Acc, []};
parse_name([H|T], Acc) when H == $(; H == $\ -> {Acc,[H|T]};
parse_name([H|T], Acc) when H /= $(; H /= $\ ->
  parse_name(T, Acc ++ [H]).

parse_parameters([],     Acc) -> Acc;
parse_parameters(String, Acc) ->
  {Name, Rest} = parse_parameter_name(String, []),
  parse_parameters(Rest, Acc ++ [Rest]).

parse_parameter_name(String, []) -> todo.

process_html_form(Tokens) -> todo.

write_to_file(String) -> todo.

%%% Tests

parse_name_test() ->
  Data = "Gender ([M]ale, [F]emale):",
  Rest = " ([M]ale, [F]emale):",
  {Name,Rest} = parse_name(Data, []),
  io:format("~s, Rest: ~s ~n", [Name,Rest]),
  ?assert({Name,Rest} == {"Gender",Rest}).

parse_parameter_name_test() ->
  Data = "([M]ale, [F]emale):",
  Expected = {$M, "Male", "[F]emale):"},
  Ret = parse_parameter_name(Data, []),
  ?assert(Expected == Ret).
