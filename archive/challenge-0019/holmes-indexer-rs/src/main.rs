use std::env;
use std::fs::File;
use std::io::Read;
use std::collections::HashMap;

use std::collections::hash_map::Entry;

#[derive(Debug)]
struct Line<'a> {
    line: &'a str,
    number: usize,
}

#[derive(Debug)]
struct WordOcc {
    occurence: usize,
    line_number: usize,
}

impl WordOcc {
    pub fn new(ln: usize, occ: usize) -> WordOcc {
        WordOcc {
            occurence: occ,
            line_number: ln,
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() != 2 {
        println!("Usage:\n  holmes-indexer <file>");
        return;
    }

    let fname = args.iter().nth(1).unwrap();

    let mut f: File = match File::open(fname) {
        Ok(f) => f,
        Err(e) => {
            println!("Error: problem wit file: {}", e);
            return;
        },
    };

    let mut contents = String::new();
    let _ = f.read_to_string(&mut contents);

    // make annotated lines
    let lines: Vec<Line> = contents
        .split("\n")
        .enumerate()
        .map(|e| {
            let (ix, ln) = e;
            Line { line: ln.trim(), number: ix } })
        .collect();

    let mut words_ix: HashMap<&str, WordOcc> = HashMap::new();

    for line in lines {
        let words: Vec<&str> = line.line.split(" ").collect();
        for word in words {
            match words_ix.entry(word) {
                Entry::Occupied(mut entry) => {
                    let mut wordocc = entry.get_mut();
                    wordocc.occurence += 1;
                },
                Entry::Vacant(entry) => {
                    let wordocc = WordOcc::new(line.number, 0);
                    entry.insert(wordocc);
                },
            };
        }
    }

    println!("{:#?}", words_ix);
}

