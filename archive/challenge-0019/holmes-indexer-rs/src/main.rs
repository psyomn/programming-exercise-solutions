use std::env;
use std::fs::File;
use std::io::Read;
use std::collections::HashMap;

#[derive(Debug)]
struct Line<'a> {
    line: &'a str,
    number: usize,
}

struct Word {
    occurence: usize,
    line_number: usize,
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
            Line { line: ln, number: ix } })
        .collect();

    let words: HashMap<String, usize> = HashMap::new();

}

