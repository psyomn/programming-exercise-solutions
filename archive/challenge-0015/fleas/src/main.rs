use board::Board;
mod board;

fn main() {
    let mut board = Board::new();

    board.print();

    for _ in range(0i, 50) {
        board.step();
    }
}
