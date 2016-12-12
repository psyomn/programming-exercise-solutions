open Str
open String

exception Bad_Direction

type direction =
        | Left
        | Right

type token = direction * int

let ttt: token = (Left, 12)

type cursor =
        | North
        | East
        | South
        | West

let cursor_s c =
        match c with
        | North -> 'N'
        | East -> 'E'
        | South -> 'S'
        | West -> 'W'

let apply_turn t d =
        match (t, d) with
        | (Left, North) -> West
        | (Left, West)  -> South
        | (Left, South) -> East
        | (Left, East) -> North
        | (Right, North) -> East
        | (Right, East) -> South
        | (Right, South) -> West
        | (Right, West) -> North

let char_to_direction c =
        match c with
        | 'L' -> Left
        | 'R' -> Right
        | _ -> raise Bad_Direction

let cursor_to_tuple curr =
        match curr with
        | North -> (0,  1)
        | East  -> (1,  0)
        | South -> (0, -1)
        | West  -> (-1, 0)

class coords = object(self)
        val mutable x : int = 0
        val mutable y : int = 0
        val mutable curr_direction = North

        method consume_direction t =
                curr_direction <- apply_turn t curr_direction

        method consume_number i =
                match cursor_to_tuple curr_direction with
                | (0, d) -> y <- y + i * d
                | (d, 0) -> x <- x + i * d
                | _ -> raise Bad_Direction

        method consume_token t =
                match t with
                | (dir, v) -> self#consume_direction dir; self#consume_number v; ()

        method taxicab_distance = x + y

        method print : unit =
                Printf.printf "(x:%d, y:%d|taxicab:%d|%c)\n"
                    x y
                    self#taxicab_distance
                    (cursor_s curr_direction)
end

let load_file f : string =
        let ic = open_in f in
        let n = (in_channel_length ic) - 1 in
        let s = Bytes.create n in
        really_input ic s 0 n;
        close_in ic;
        s

let parse_direction str_token : direction =
        char_to_direction str_token.[0]

let parse_dir_magnitude str_token : int =
        let strlen = String.length str_token in
        if strlen < 2 then 0 else
                let substr = String.sub str_token 1 (strlen - 1) in
                int_of_string substr

let parse_token str_token : token =
        (parse_direction str_token, parse_dir_magnitude str_token)

let parse_file_data: token list =
        let data_file_name = "data.txt" in
        let file_s = load_file data_file_name in
        let str_tokens: string list = Str.split (Str.regexp ", *") file_s in
        List.map (fun x -> parse_token x) str_tokens

let () =
        let adv_coords = new coords in
        let tokens = parse_file_data in
        let _ = List.iter (fun x -> adv_coords#consume_token x) tokens in
        let _ = adv_coords#print in
        ()
