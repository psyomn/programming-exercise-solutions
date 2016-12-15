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
end
