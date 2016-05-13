use std::io;

fn main() -> () {
    let mut s = String::new();

    io::stdin().read_line(&mut s).unwrap();

    let number = s.trim().parse::<u32>().expect("not a number");

    println!("{}", count_bit_seq(number));
}

fn count_bit_seq(x: u32) -> u8 {
    let mut y = x;
    let mut max: u8 = 0;
    let mut curr: u8 = 1;
    let mut curr_score: u8 = 0;

    for _ in 0..32 {
        curr &= (y & 1) as u8;
        y >>= 1;

        if curr == 1 {
            curr_score += 1;
        }
        else {
            max = if max < curr_score { curr_score } else { max };
            curr = 1;
            curr_score = 0;
        }
    }

    max
}
