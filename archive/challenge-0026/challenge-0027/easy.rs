use std::io;

fn main() -> () {
    let mut s = String::new();

    io::stdin().read_line(&mut s).unwrap();

    let year_f: f32 = s.trim().parse::<f32>().expect("not a number") / 100.0;

    if year_f < 0.0 {
        panic!("can only support years greater/equal to 0 for now");
    }

    println!("{}", year_f.round());
}
