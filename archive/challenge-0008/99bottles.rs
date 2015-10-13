use std::env;

fn plurals(i: u32) -> char {
    match i {
        0 => 's',
        1 => ' ',
        _ => 's',
    }
}

fn last_phrase(n: u32) -> String {
    let p: char = plurals(n);
    match n {
        0 => "no more bottles on the wall\n".to_string(),
        _ => format!("{}{}{}{}",
                     n, " bottle", p.to_string(), " on the wall \n"),
    }
}

fn phrase(n: u32) -> String {
    let s: String = format!("{}{}{}{}",
        last_phrase(n),
        last_phrase(n),
        "take one down, pass it around\n",
        last_phrase(n - 1));
    s
}

fn main() -> () {
    let args: Vec<String> = env::args().collect();
    let times = match args.iter().nth(1) {
        Some(v) => {
            match v.parse::<u32>() {
                Ok(v) => v,
                Err(..) => panic!("You need to provide an unsigned integer!"),
            }
        },
        None => {
            println!("Usage:\n  99bottles <number>");
            return;
        },
    };

    for i in (1..times + 1).rev() {
        println!("{}", phrase(i));
    }
}
