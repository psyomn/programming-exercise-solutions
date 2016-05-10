use std::io;

trait Palindrome {
    fn palindromic(&self) -> bool;
}

impl Palindrome for String {
    fn palindromic(&self) -> bool {
        let len = self.len();
        let stopping_ix = if len % 2 == 0 { len / 2 } else { len / 2 + 1 };

        let mut start_iter = self.chars();
        let mut end_iter = self.chars().rev();

        for _ in 0..stopping_ix {
            let start = start_iter.next().unwrap();
            let end = end_iter.next().unwrap();
            if start != end { return false }
        }

        true
    }
}

fn main() -> () {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();

    println!("{}", s.trim().to_string().palindromic());
}
