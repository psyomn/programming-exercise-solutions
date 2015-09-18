use std::io;
use std::io::prelude::*;

fn main() {
    let mut info : Vec<String> = vec!();
    let queries : Vec<&str> = vec![
        "name", "age", "reddit username"
    ];

    for query in queries {
        let mut s : String = String::new();
        print!("{} : ", query);
        io::stdout().flush().unwrap();
        match io::stdin().read_line(&mut s) {
            Ok(..) => info.push(s.trim().to_string()),
            _ => {},
        }
    }

    println!("Your name is {}, your age is {}, and your username is {}.",
             info[0], info[1], info[2]);
}
