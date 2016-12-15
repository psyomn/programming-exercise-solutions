open Sys

open Adv1
open Adv2
open Adv3

exception User_is_stupid

let () =
        try
                match (Sys.getenv "ADVONLY") with
                | "1" -> Adv1.run ()
                | "2" -> Adv2.run ()
                | "3" -> Adv3.run ()
                | _   -> raise User_is_stupid

        with Not_found ->
                Adv1.run ();
                Adv2.run ();
                Adv3.run ()
