extern crate regex;

use regex::Regex;

use std::fs::File;
use std::io::Read;
use std::env;

fn main() -> () {
    let args: Vec<String> = env::args().collect();
    let data_path: String = match args.iter().nth(1) {
        Some(v) => v.clone(),
        None => panic!("Need a data path"),
    };

    println!("Using path: {}", data_path);

    let mut s: String = String::new();

    let mut f: File = match File::open(data_path) {
        Ok(f) => f,
        Err(e) => panic!("{}", e),
    };

    let _ = f.read_to_string(&mut s).unwrap();

    let re: Regex = Regex::new(r"(?i)adventure\s+(i|ii|iii|iv|v|vi|vii|viii|ix|x|xi|xii)").unwrap();

    let split_iter = re.split(&s);
    let mut vec: Vec<(usize,usize)> = Vec::new();

    for (ix, part) in split_iter.enumerate() {
        let words = part.split(" ").count();
        vec.push( (ix, words) );
    }

    vec.sort_by(|a,b| {
        let (_, words_a) = *a;
        let (_, words_b) = *b;
        words_b.cmp(&words_a) } );

    for (ix,words) in vec {
        println!("part: {}, words: {}", ix, words);
    }
}
