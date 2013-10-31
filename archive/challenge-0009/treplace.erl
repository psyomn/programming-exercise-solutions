-module(treplace).
-author("lethaljellybean@gamil.com").
-export([main/1]).

%% @doc The main routine.
%%  This is to solve challenge 9 intermediate of /r/dailyprogrammer. The 
%%  challenge requires you to write some sort of utility like `sed` that scans
%%  some input and replaces a pattern (in our case a string sequence, with
%%  another string sequence). Erlang is not good with strings apparently, but
%%  it's still interesting to see how Regular Expressions can be used (and file
%%  io since it's not a topic I've personally seen too many times on erlang).
main(ARGS) ->
  case check_args(ARGS) of 
    true  -> replace_occurences(ARGS);
    false -> io:format("Correct usage is: ~n"),
      io:format("  treplace <file> <term-to-search> <replace-with-term>"),
      io:format("~n")
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
  ModifiedContents = replace_strings(FileContents, SearchTerm, ReplaceTerm),
  write_file(Filename ++ ".edited", ModifiedContents).

%% @doc 
read_file(Filename) ->
  {Status, Device} = file:open(Filename, read),
  case Status of 
    ok -> read_all_contents(Device);
    _  -> error("could not open file")
  end.

%% @doc Given an IoDevice, read everything from the file, and return a string.
%%   On a normal call, set Str as [] (Str is an accumulator).
read_all_contents(Device) -> read_all_contents(Device, []).
read_all_contents(Device, Str) ->
  case file:read_line(Device) of
    eof -> Str;
    {ok, Next} -> read_all_contents(Device, Str ++ Next)
  end.

%% @doc replace a string, given replace pattern
replace_strings(String, Match, Replace) -> 
  re:replace(String, Match, Replace, [{return,list},global]).

%% @doc Write into the given absolute path, the given string.
write_file(Filename, Contents) -> 
  {_,Io} = file:open(Filename, write),
  file:write(Io, Contents),
  file:close(Io).

