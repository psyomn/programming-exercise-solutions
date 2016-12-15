open Advent
open Str

module Adv3 = struct
        let rec count_occurences l e acc =
                match l with
                | head :: rest ->
                        if head = e then count_occurences rest e (acc + 1)
                        else count_occurences rest e acc
                | [] -> acc

        let convert_row str =
                let num_strs = Str.split (Str.regexp " +") str in
                let x = List.map int_of_string num_strs in
                (List.nth x 0, List.nth x 1, List.nth x 2)

        let is_triangular tup : bool =
                let x, y, z = tup in
                (x + y) > z &&
                (y + z) > x &&
                (z + x) > y

        let run () =
                let lines = Advent.data_lines "data/3" in
                let conv_lines = List.map convert_row lines in
                let triangle_checks = List.map is_triangular conv_lines in
                let count = count_occurences triangle_checks true 0 in
                Printf.printf "Adv3 number of triangles: %d\n" count
end
