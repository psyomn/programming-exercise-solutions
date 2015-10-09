extern crate morse;
extern crate getopts;

use std::collections::HashMap;
use getopts::Options;
use std::env;

use morse::{make_morse_hash, make_alpha_hash};

fn print_usage(program: &str, opts: Options) -> () {
    let brief = format!("Usage: {} File [options]", program);
    print!("{}", opts.usage(&brief));
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let mut opts = Options::new();
    opts.optflag("m", "morse", "generate morse from alphabetic input");
    opts.optflag("a", "alpha", "generate alphabetic stuff from morse input");
    opts.optflag("h", "help", "show help");

    let matches = match opts.parse(&args[1..]) {
        Ok(m) => { m },
        Err(f) => { panic!("{}", f) },
    };

    if matches.opt_present("h") {
        print_usage(args[0].as_ref(), opts);
        return;
    }

    if matches.opt_present("m") {
        let last = match args.last() {
            Some(v) => v.clone(),
            None => return,
        };

        let alpha: HashMap<String,String> = make_alpha_hash();
        let signals: Vec<&str> = last.split(" ").collect::<Vec<&str>>();

        for c in signals.iter() {
            match alpha.get(c.to_string()) {
                Some(v) => print!("{}", v),
                None => {},
            }
        }

        return;
    }

    if matches.opt_present("a") {
        return;
    }
}
