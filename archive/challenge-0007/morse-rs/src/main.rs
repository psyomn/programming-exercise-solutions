extern crate morse;
extern crate getopts;

use std::convert::AsRef;
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
    let mut fake_args: Vec<String> = Vec::new();

    match args.iter().nth(1) {
        Some(v) => {
            let vv = v.clone();
            fake_args.push(vv);
        },
        None => {},
    }

    let mut opts = Options::new();
    opts.optflag("m", "morse", "generate morse from alphabetic input");
    opts.optflag("a", "alpha", "generate alphabetic stuff from morse input");
    opts.optflag("h", "help", "show help");

    let matches = match opts.parse(&fake_args[0..]) {
        Ok(m) => { m },
        Err(f) => { panic!("{}", f) },
    };

    if matches.opt_present("h") {
        print_usage(args[0].as_ref(), opts);
        return;
    }

    if matches.opt_present("m") {
        let cargs: Vec<String> = args.iter().cloned().skip(2).collect();
        let s: String = morse::morse_to_ascii(cargs.join(" "));
        println!("{}", s);
        return;
    }

    if matches.opt_present("a") {
        let cargs: Vec<String> = args.iter().cloned().skip(2).collect();
        let s: String = morse::ascii_to_morse(cargs.join(" "));
        println!("{}", s);
        return;
    }
}
