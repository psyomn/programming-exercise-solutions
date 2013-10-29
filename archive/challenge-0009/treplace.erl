-module(treplace).
-author("lethaljellybean@gamil.com").
-compile(export_all).

%% @doc The main routine.
main(ARGS) ->
  case check_args(ARGS) of 
    true  -> replace_occurences(ARGS);
    false -> io:format("Correct usage is: ~n"),
     io:format("  treplace <file> <term-to-search> <replace-with-term>"),
     io:format("~n~n")
  end.

%% @doc check if the arguments that are given are right. If everything is ok,
%%   then go to main program logic, else print error message, along with 
%%   instructions.
check_args(ARGS) ->
  case erlang:length(ARGS) of
    3 -> true;
    _ -> false
  end.

%% @doc interfacing function to take care of things
replace_occurences(ARGS) -> 
  [Filename, SearchTerm, ReplaceTerm] = ARGS,
  FileContents = read_file(Filename), 
  io:format(FileContents).

%% @doc 
read_file(Filename) ->
  {Status, Device} = file:open(Filename, read),
  case Status of 
    ok -> read_all_contents(Device, derp);
    _  -> error("could not open file")
  end.

read_all_contents(_, eof) -> [];
read_all_contents(Device, _) ->
  {Status, Str} = file:read_line(Device),
  Str ++ read_all_contents(Device, Status).

%% @doc replace a string, given replace pattern
replace_strings(String, Match, Replace) -> todo.

%% @doc Write into the given absolute path, the given string.
write_file(Filename, Contents) -> todo.

