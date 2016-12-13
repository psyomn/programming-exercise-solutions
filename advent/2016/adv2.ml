open Sys
open Str
open Printf

module Adv2 = struct
        exception Bad_Coord_To_Number
        exception Bad_Char_Direction

        let filename =
                try Sys.getenv "ADV2"
                with Not_found -> "data/2"

        type directions =
                | Up
                | Down
                | Left
                | Right

        let incr v =
                match v with
                | 1 -> 1
                | 0 -> 1
                | -1 -> 0
                | x -> x

        let decr v =
                match v with
                | 1 -> 0
                | 0 -> -1
                | -1 -> -1
                | x -> x

        let char_to_dir c =
                match c with
                | 'R' -> Right
                | 'L' -> Left
                | 'U' -> Up
                | 'D' -> Down
                | _   -> raise Bad_Char_Direction

        let char_list_to_dir_list cl = List.map char_to_dir cl

        (*
         * 1 2 3   (-1  1):1 (0  1):2 (1  1):3
         * 4 5 6   (-1  0):4 (0  0):5 (1  0):6
         * 7 8 9   (-1 -1):7 (0 -1):8 (1 -1):9
         *)
        let coord_to_keypad c =
                match c with
                | -1,  1 -> 1
                | -1,  0 -> 4
                | -1, -1 -> 7
                | 0,   0 -> 5
                | 0,   1 -> 2
                | 0,  -1 -> 8
                | 1,   0 -> 6
                | 1,  -1 -> 9
                | 1,   1 -> 3
                | _,   _ -> raise Bad_Coord_To_Number

        let apply_direction c d =
                match d, c with
                | Up,    (x, y) -> (x, incr y)
                | Down,  (x, y) -> (x, decr y)
                | Left,  (x, y) -> (decr x, y)
                | Right, (x, y) -> (incr x, y)

        let print_tuple (x, y) = printf "(%d, %d)\n" x y

        let print_direction d =
                match d with
                | Right -> print_string "r "
                | Left  -> print_string "l "
                | Up    -> print_string "u "
                | Down  -> print_string "d "

        let rec print_list l =
                match l with
                | head :: rest -> print_int head; print_list rest
                | [] -> print_endline ""

        let data_lines f =
                let ic = open_in f in
                let n = (in_channel_length ic) in
                let s = Bytes.create n in
                really_input ic s 0 n;
                close_in ic;
                Str.split (Str.regexp "\n") s

        let str_to_charlist str =
                let rec exp i l =
                if i < 0 then l else exp (i - 1) (str.[i] :: l) in
                exp (String.length str - 1) []

        let prepare_data () =
                let chr_data = List.map str_to_charlist (data_lines filename) in
                List.map char_list_to_dir_list chr_data

        let rec consume_row c row =
                match row with
                | dir_head :: rest -> consume_row (apply_direction c dir_head) rest
                | [] -> c

        let rec process_all_movement coords movement_list =
                match movement_list with
                | [] -> []
                | mov_list :: rest ->
                        let last_coord = consume_row coords mov_list in
                        let number = coord_to_keypad last_coord in
                        number :: process_all_movement last_coord rest

        let run =
                let data = prepare_data () in
                let code = process_all_movement (0, 0) data in
                print_list code

end
