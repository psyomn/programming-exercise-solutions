use std::rand;
use std::rand::Rng;
use std::collections::HashMap;

pub use board::Direction::{ N, S, E, W };
#[deriving(PartialEq, Eq)]
pub enum Direction { N, S, E, W }

pub struct Board {
    tiles: [[int, ..30], ..30],
}

/// Model for the board with fleas
impl Board {

    /// make a board, where each cell is initialized to 1
    pub fn new() -> Board {
        Board{tiles: [[1, ..30], ..30]}
    }

    /// Model the bell ringing
    pub fn step(&mut self) {
        let mut height_rng = range(0i, self.tiles.len() as int);
        let mut row_rng    = range(0i, self.tiles[0].len() as int);

        for y in height_rng {
            for x in row_rng {
                self.displace_coordinate(x, y);
            }
        }
    }

    fn displace_coordinate(&mut self, x: int, y: int) {
        let row_max        = self.row_max();
        let height_max     = self.height_max();
        let mut r          = rand::task_rng();
        let mut height_rng = range(0i, self.tiles.len() as int);
        let mut row_rng    = range(0i, self.tiles[0].len() as int);

        for y in height_rng {
            for x in row_rng {
                match (x, y) {
                    (0, 0) => {
                        let d: Direction = if r.gen::<int>() % 2 == 0 { S } else { E };
                        let (_x, _y): (int,int) = Board::move_to(d);
                        let mut nx = _x + x;
                        let mut ny = _y + y;
                        self.tiles[x as uint][y as uint] -= 1;
                    }

                    (row_max, 0) => {
                    }
                    (_, _) => {}
                }
            }
        }
    }

    fn move_to(d: Direction) -> (int,int) {
        match d {
            N => (0i, -1),
            S => (0i,  1),
            E => (-1i, 0),
            W => (1i,  0),
        }
    }

    fn row_max(&self) -> int { self.tiles.len() as int }

    fn height_max(&self) -> int { self.tiles.len() as int }

    pub fn print(&self) {
        for y in self.tiles.iter() {
            for x in y.iter() {
                print!("{} ", x);
            }
            println!("");
        }
    }

}

/// Get a random direction
fn random_direction() -> Direction {
    let mut r = rand::task_rng();

    match (r.gen::<int>() % 4) {
        0 => N,
        1 => S,
        2 => E,
        3 => W,
        _ => N,
    }
}

