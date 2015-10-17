extern crate fleas;

use fleas::board::Board;
use std::io::Write;

fn main() {
    let mut results = vec![];

    for _ in 0..20 {
        print!(".");
        std::io::stdout().flush().unwrap();
        results.push(simulate());
    }

    let veclen = results.len();
    let sum = results.iter().fold(0, |v,t| v + *t);
    let approximation : f64 = sum as f64 / veclen as f64;

    println!("");
    println!("An approximation of empty cells is: {:.6}", approximation);

}

/// Run the whole thing once, return the number of empty cells
fn simulate() -> u32 {
    let mut board = Board::new();
    for _ in 0..50 {
        // Uncomment the bellow if you want to print the boards
        // board.print();
        board.step();
        // println!("");
    }
    board.count_zeros()
}
