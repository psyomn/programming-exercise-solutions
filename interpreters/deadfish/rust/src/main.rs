use std::env;
use std::io::prelude::*;
use std::io;

fn main() {
    let mut args: Vec<String> = env::args().collect();

    if args.len() == 0 {
        println!("Usage:\n  deadfish-rs [idso]+");
        return;
    }

    let s: String = args.pop().unwrap().to_string();
    let mut value : u32 = 0;

    for c in s.chars() {
        match c {
            'i' => value += 1,
            'd' => value -= 1,
            's' => value *= value,
            'o' => print!("{}", std::char::from_u32(value).unwrap()),
            _   => panic!("[idso]+ is the only allowed input"),
        }
    }
    io::stdout().flush().unwrap();
}
