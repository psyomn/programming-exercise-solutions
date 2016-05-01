use std::io;

fn main() -> () {
    let mut input = String::new();

    io::stdin().read_line(&mut input).unwrap();

    let number = input
        .trim()
        .parse::<i32>()
        .unwrap();

    println!("{:b}", number);
}
