extern crate ppp;

use std::io;
use std::io::Write;

fn main() -> () {
    let mut username: String = String::new();
    let mut password: String = String::new();

    print!("Enter username: ");
    io::stdout().flush().unwrap();
    (io::stdin().read_line(&mut username)).unwrap();
    print!("Enter password: ");
    io::stdout().flush().unwrap();
    (io::stdin().read_line(&mut password)).unwrap();

    let uu: String = username.trim().to_string();
    let pp: String = password.trim().to_string();

    match ppp::attempt_authentication(uu, pp) {
        true  => println!("authentication successful!"),
        false => println!("access denied!"),
    }
}
