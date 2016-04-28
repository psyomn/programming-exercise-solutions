use std::io;

fn main() -> () {
    let mut input = String::new();

    io::stdin().read_line(&mut input).unwrap();

    let max = input.trim().parse::<i32>().expect("not a number");

    if max < 0 {
        panic!("You need to supply a positive integer");
    }

    let numbers: Vec<i32> =
        (0..max)
        .filter(|e| ((e % 20) % 9) % 6 != 0)
        .collect();

    println!("{:?}", numbers);
}
