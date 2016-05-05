use std::io;
use std::fmt;

enum Oddity {
    Weird,
    NotWeird,
    Derpity,
}

trait Weirdness {
    fn weird(&self) -> Oddity;
}

impl Weirdness for i64 {
    fn weird(&self) -> Oddity {
        match *self {
            n @ 2...5 if n % 2 == 0 => Oddity::NotWeird,
            n @ 6...20 if n % 2 == 0 => Oddity::Weird,
            n @ _ if n % 2 == 1 => Oddity::Weird,
            n @ _ if n > 20 && n % 2 == 0 => Oddity::NotWeird,
            _ => Oddity::Derpity,
        }
    }
}

impl fmt::Display for Oddity {
   fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
       let ret = match *self {
           Oddity::Weird => "Weird",
           Oddity::NotWeird => "Not Weird",
           Oddity::Derpity => "DERP DERP",
       };

       write!(f, "{}", ret)
   }
}

fn main() -> () {
    let mut s = String::new();

    io::stdin().read_line(&mut s).unwrap();

    let num: i64 = s.trim().parse().expect("not a number");

    println!("{}", num.weird());
}
