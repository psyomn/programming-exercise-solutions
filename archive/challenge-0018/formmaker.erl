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

%% @doc Takes in screen from text file. Outputs a list of tuples representing
%%   the information in the following format:
%%   [{"Question",[{"M", "Male"},
%%                 {"F","Female"]}]
parse(String) ->
  Questions = parse_questions(String).

%% @doc this gets the label of the question. Return {LabelName, Rest}
parse_name([]   , Acc) -> {Acc, []};
parse_name([H|T], Acc) when H == $(; H == $\ -> {Acc,[H|T]};
parse_name([H|T], Acc) when H /= $(; H /= $\ ->
  parse_name(T, Acc ++ [H]).

parse_parameters([],     Acc) -> Acc;
parse_parameters([H|T],  Acc) ->
  case H of
    $) ->
      Acc;
    $\ ->
      parse_parameters(T, Acc); % skip whitespace
    $: ->
      parse_parameters(T, Acc); % skip whitespace
    _  ->
      {Label, Name, Rest} = parse_parameter_name([H|T], [], none),
      parse_parameters(Rest, Acc ++ [{Label, Name}])
  end.

parse_parameter_name([],    Acc, Label) -> {Label, Acc, []};
parse_parameter_name(Str,   Acc, none)  ->
  L = parse_label(Str, []),
  parse_parameter_name(Str, Acc, L);
parse_parameter_name([H|T], Acc, Label) when H == $, ;
                                             H == $)
                                             -> {Label, Acc, T};
parse_parameter_name([H|T], Acc, Label) ->
  case lists:member(H, [$(, $[, $]]) of
    true  -> parse_parameter_name(T, Acc, Label); % skip
    false -> parse_parameter_name(T, Acc ++ [H], Label)
  end.

%% @doc [M]ale -> "M", "[Fem]ale" -> "Fem"
parse_label([],    Label) -> Label;
parse_label([H|_], Label) when H == $] -> Label;
parse_label([H|T], Label) when H == $[ ; H == $( ->
  parse_label(T, Label);
parse_label([H|T], Label) ->
  parse_label(T, Label ++ [H]).

%% @doc Given a string which represents the whole form, we return each
%%   individual question.
parse_questions(String) ->
  string:tokens(String, ":").

process_html_form(Tokens) -> todo.

write_to_file(String) -> todo.

%%% Tests

parse_name_test() ->
  Data = "Gender ([M]ale, [F]emale):",
  Rest = " ([M]ale, [F]emale):",
  {Name,Rest} = parse_name(Data, []),
  ?assert({Name,Rest} == {"Gender",Rest}).

parse_parameter_name_test() ->
  Data = "([M]ale, [F]emale):",
  Expected = {"M", "Male", " [F]emale):"},
  Ret = parse_parameter_name(Data, [], none),
  ?assert(Expected == Ret).

parse_label_test() ->
  Data = "[M]ale",
  Expected = "M",
  Data2 = "[Ma]le",
  Expected2 = "Ma",
  Ret  = parse_label(Data,  []),
  Ret2 = parse_label(Data2, []),
  ?assert(Ret  == Expected),
  ?assert(Ret2 == Expected2).

parse_questions_test() ->
  Data = "Gender ([M]ale, [F]emale):~nPotato ([P]otato, [Yo]tato):",
  Ret = parse_questions(Data),
  ?assert(erlang:length(Ret) == 2).

parse_parameters_test() ->
  Data  = "([M]ale, [F]emale):",
  Data2 = "([M]ale, [Fem]ale):",
  Ret  = parse_parameters(Data, []),
  Ret2 = parse_parameters(Data2, []),
  Expected = [{"M", "Male"}, {"F", "Female"}],
  Expected2 = [{"M", "Male"}, {"Fem", "Female"}],
  ?assert(Expected == Ret),
  ?assert(Expected2 == Ret2).
