use board::Board;
mod board;

fn main() {
    let mut board = Board::new();

    for _ in range(0i, 50) {
        board.print();
        board.step();
        println!("");
    }
}
