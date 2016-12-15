open Advent
open Str

module Adv3 = struct
        exception Bad_data

        let rec count_occurences l e acc =
                match l with
                | head :: rest ->
                        if head = e then count_occurences rest e (acc + 1)
                        else count_occurences rest e acc
                | [] -> acc

        let to_num_list str =
                let num_strs = Str.split (Str.regexp " +") str in
                List.map int_of_string num_strs

        let convert_row str =
                let x = to_num_list str in
                (List.nth x 0, List.nth x 1, List.nth x 2)

        let is_triangular tup : bool =
                let x, y, z = tup in
                (x + y) > z &&
                (y + z) > x &&
                (z + x) > y

        let rec transpose l =
                match l with
                | a :: b :: c :: rest -> Advent.zip3 a b c @ transpose rest
                | [] -> []
                | _ -> raise Bad_data

        let part1 () =
                let lines = Advent.data_lines "data/3" in
                let conv_lines = List.map convert_row lines in
                let triangle_checks = List.map is_triangular conv_lines in
                let count = count_occurences triangle_checks true 0 in
                Printf.printf "Adv3 p1: %d\n" count

        let part2 () =
                let lines = Advent.data_lines "data/3" in
                let numlist = List.map to_num_list lines in
                let translist = transpose numlist in
                let triangle_checks = List.map is_triangular translist in
                let count = count_occurences triangle_checks true 0 in
                Printf.printf "Adv3 p2: %d\n" count

        let run () =
                part1 () ;
                part2 ()
end
