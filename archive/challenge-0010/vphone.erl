-author("lethaljellybean@gmail.com").
-export([main/1]).

%% @doc We don't care about the rest of the arguments given. Check the first
%%   argument to see if it's a valid phone.

main(ARGS) ->
  case ARGS of 
    [] -> io:format("Usage: ~n"),
          io:format("  vphone <phone-number>~n~n");
    [First|_] -> io:format("~p~n", [has_bad_chars(First)])
  end.

%% @doc Phone is a string
has_bad_chars(Phone) ->
  case re:run(Phone, "(?=.*[-.].*)(?=.*[0-9].*)") of
    nomatch -> invalid;
    _       -> check_format(Phone)
  end.

%% @doc is it in valid format? 
check_format(Phone) ->
  SplitList = re:split(Phone, "[.-]", [{return,list}]),
  AllAbove3 = lists:foldl(fun(X, Y) -> Y and bigger3(X) end, true, SplitList),
  case AllAbove3 of
    true  -> valid;
    false -> invalid
  end.

%% @doc is the string bigger than 3?
bigger3(String) ->
  lst_bigger_than(String, 2).

%% @doc quickhand to compare lists to lengths
lst_bigger_than(Lst, Size) ->
  erlang:length(Lst) > Size.


