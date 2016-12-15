module Advent : sig
(* Common functionality which may be used for the rest of advent of code
 * goes here *)

        val load_file: string -> string
        (* get contents of a file provided its filename *)

        val data_lines: string -> string list
        (* load file as list of lines *)
end
