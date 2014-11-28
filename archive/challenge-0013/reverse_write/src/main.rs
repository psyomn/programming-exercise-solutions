use std::io;
use std::io::File;
/*
 * Get an input string, reverse it, and write it to a file.
 */
fn main() {
    println!("Enter a string: ");
    let input:    String = io::stdin().read_line().unwrap();
    let reversed: String = input.as_slice().chars().rev().collect();

    let mut file = File::create(&Path::new("result.txt"));
    file.write_line(reversed.as_slice());
}
