extern crate phone;

use std::env;

/// Valid phone numbers should be:
/// 1234567890,
/// 123-456-7890,
/// 123.456.7890,
/// (123)456-7890,
/// (123) 456-7890 (note the white space following the area code),
/// and 456-7890
fn main() {
    let phone_number: Vec<String> = env::args().collect();
    let number: &str = match phone_number.iter().nth(1) {
        Some(v) => v.as_ref(),
        None => panic!("Usage:\n  phone <phonenumber>"),
    };

    match phone::valid_phone(number) {
        true => println!("Valid phone!"),
        false => println!("Invalid phone!"),
    }
}

