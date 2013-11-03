-module(symbanagrams).
-author("lethaljellybean@gmail.com").
-compile(export_all).

main(ARGV) ->
  case ARGV of 
    [] -> print_usage();
    [First|_] -> 
      is_anagram(First, First)
  end.

print_usage() ->
  io:format("~s~n", ["Usage: "]),
  io:format("~s~n", ["  symbanagrams <terms>"]).

is_anagram(Str, Str2) -> 
  NoSpace1 = rm_space(Str),
  NoSpace2 = rm_space(Str2),
  all_occurences(Str) == all_occurences(Str2).
  
rm_space(Str) -> rm_substr(Str, " ").
rm_substr(Str, Sub) -> re:replace(Str, Sub, "", [global,{return,list}]).

all_occurences([])  -> [];
all_occurences(Str) ->
  [H|_] = Str,
  NextStr = rm_substr(Str, H),
  LetterCount = letter_occurence(Str,H),
  [{H, LetterCount}|all_occurences(NextStr)].

letter_occurence(String, Letter) ->
  case re:run(String, [Letter], [global]) of
    {_, Matches} -> erlang:length(Matches);
    _ -> 0
  end.

remove_occurences([], _) -> [];
remove_occurences(String, Letter) ->
  [H|T] = String, 
  case H == Letter of 
  true  -> [remove_occurences(T, Letter)];
  false -> [H|remove_occurences(T, Letter)]
  end.

