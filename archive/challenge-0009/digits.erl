-module(digits).
-author(psyomn).
-compile(export_all).

main(ARGS) ->
  Args     = make(ARGS),
  Sorted   = lists:sort(Args),
  print_list(Sorted).

%% @doc This delegates to the proper make function
make(List) when is_list(List) ->
  [H|_] = List,
  HInt = make_number(H),
  if 
    error            == HInt -> List;
    is_integer(HInt) == true -> make_int(List);
    true                     -> {error, wat_do_with_list}
  end.

%% @doc mapping shorthand to convert lists to int lists
make_int([]) -> [];
make_int(List) -> 
  lists:map(fun(X) -> digits:make_number(X) end, List).

make_number(X) -> 
  {HeadInt, _} = string:to_integer(X),
  HeadInt.

print_list(List) ->
  [Sample|_] = List,
  if 
    is_integer(Sample) == true -> print_int_list(List);
    is_list(Sample)    == true -> print_str_list(List);
    true               -> {error, dunno_how_to_print_that}
  end.
  
print_str_list([])    -> io:format("~n");
print_str_list([H|T]) ->
  io:format("~s ", [H]),
  print_str_list(T).

print_int_list([])    -> io:format("~n");
print_int_list([H|T]) ->
  io:format("~p ", [H]),
  print_int_list(T).
