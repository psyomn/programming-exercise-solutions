use std::collections::BTreeMap;

use std::env;
use std::io::Read;
use std::fs::File;

fn main() {
    let args: Vec<String> = env::args().collect();
    let filename: String = match args.iter().nth(1) {
        Some(v) => v.clone(),
        None => panic!("You need to provide a filename to read from"),
    };

    let mut f: File = match File::open(filename) {
        Ok(v) => v,
        Err(e) => panic!(e),
    };

    let mut contents: String = String::new();

    match f.read_to_string(&mut contents) {
        Ok(v) => println!("Read {} bytes", v),
        Err(e) => panic!(e),
    }

    let mut counts: BTreeMap<char, u64> = BTreeMap::new();
    let alpha: &str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let numeric: &str = "0123456789";

    for c in alpha.chars() {
        counts.insert(c, 0);
    }

    for c in numeric.chars() {
        counts.insert(c, 0);
    }

    for c in contents.chars() {
        match counts.contains_key(&c) {
            false => continue,
            true => {
                let prev = counts.get(&c).unwrap().clone();
                counts.insert(c, prev + 1);
            },
        };
    }

    println!("{:#?}", counts);
}
