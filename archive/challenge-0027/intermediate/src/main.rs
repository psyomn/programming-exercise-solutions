extern crate chrono;

use chrono::*;

use std::io;

fn main() -> () {
    let mut s = String::new();

    io::stdin().read_line(&mut s).unwrap();

    let start_year: i32 = s.trim().parse::<i32>().expect("not a number");

    if start_year < 0 {
        panic!("bad year");
    }

    let mut sat_count: usize = 0;

    for offset in 0..101 {
        let date = UTC.ymd(start_year + offset, 3, 17);
        let fmt: String = date.format("%a").to_string();
        if fmt == "Sat".to_string() { sat_count += 1 }
    }

    println!("{}", sat_count);
}
