module Advent = struct
        let load_file f : string =
                let ic = open_in f in
                let n = (in_channel_length ic) in
                let s = Bytes.create n in
                really_input ic s 0 n;
                close_in ic;
                s

        let data_lines f =
                let ic = open_in f in
                let n = (in_channel_length ic) in
                let s = Bytes.create n in
                really_input ic s 0 n;
                close_in ic;
                Str.split (Str.regexp "\n") s

        let rec zip3 l1 l2 l3 =
                match l1 with
                | hd :: rest ->
                        let h2 = List.hd l2 and
                        h3 = List.hd l3 and
                        t2 = List.tl l2 and
                        t3 = List.tl l3 in
                        (hd, h2, h3) :: zip3 rest t2 t3
                | [] -> []
end
