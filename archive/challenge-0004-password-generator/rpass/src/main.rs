extern crate rpass;
extern crate getopts;

use std::env;
use getopts::Options;

use rpass::{random_password};

fn main() {
    let mut ar: Vec<String> = env::args().collect();

    if ar.len() != 3 {
        println!("Usage:");
        println!("  rpass <number> <number>");
        return;
    }

    let y = ar.pop().unwrap().parse::<u32>();
    let x = ar.pop().unwrap().parse::<u32>();

    let rx = match x {
        Ok(v)   => v,
        Err(..) => panic!("You need to pass an integer"),
    };

    let ry = match y {
        Ok(v)   => v,
        Err(..) => panic!("You need to pass an integer"),
    };

    print!("{}", random_password(rx, ry));
}
