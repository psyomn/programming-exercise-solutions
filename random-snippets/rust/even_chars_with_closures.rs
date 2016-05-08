use std::io;

fn main() -> () {
    let mut s = String::new();

    io::stdin().read_line(&mut s).unwrap();

    let num_input = s.trim().parse::<i32>().expect("not a number");

    for _ in 0..num_input {
        process_input(read_input());
    }
}

fn read_input() -> String {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();
    s.trim().to_string()
}

fn process_input(s: String) -> () {
    let even_str: String = map_chars(&s, |x| x % 2 == 0);
    let odd_str: String = map_chars(&s, |x| x % 2 == 1);

    println!("{} {}", even_str, odd_str);
}

fn map_chars<F>(s: &String, pred: F)
    -> String
    where F : Fn(usize) -> bool {
    s.chars()
     .enumerate()
     .into_iter()
     .filter(|&(ix,_)| pred(ix))
     .map(|(_,e)| e)
     .collect()
}
