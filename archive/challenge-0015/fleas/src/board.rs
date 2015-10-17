extern crate rand;
use rand::Rng;

pub use board::Direction::{ N, S, E, W };
#[derive(PartialEq, Eq)]
pub enum Direction { N, S, E, W }

pub struct Board {
    tiles: [[i32; 30]; 30],
    step: u32,
}

/// Get a random direction
fn random_direction() -> Direction {
    let mut r = rand::thread_rng();
    let d: u32 = r.gen::<u32>() % 4;

    match d {
        0 => N,
        1 => S,
        2 => E,
        3 => W,
        _ => S,
    }
}

/// Given some directions in an array, we choose one of them and return it.
fn rand_direction_from_arr(darr: &[Direction]) -> Direction {
    let max = darr.len();
    let mut r = rand::thread_rng();
    darr[r.gen::<u32>() % max]
}


/// Model for the board with fleas
impl Board {

    /// make a board, where each cell is initialized to 1
    pub fn new() -> Board {
        Board{tiles: [[1; 30]; 30], step: 0}
    }

    /// Count how many cells are equal to zero
    pub fn count_zeros(&self) -> u32 {
        let mut counter = 0;

        for y in self.tiles.iter() {
            for x in y.iter() {
                counter += if *x == 0 { 1 } else { 0 };
            }
        }

        counter
    }

    /// Model the bell ringing
    pub fn step(&mut self) {
        let mut height_rng = (0 .. self.tiles.len() as i32);
        let mut row_rng    = (0 .. self.tiles[0].len() as i32);

        self.step += 1;

        for _ in height_rng {
            for _ in row_rng {
                self.displace_coordinate();
            }
        }
    }

    /// This code is kind of awful :(. Pretty horrible. Ugh.
    fn displace_coordinate(&mut self) {
        let row_max          = self.row_max() - 1;
        let height_max       = self.height_max() - 1;
        let mut height_rng   = 0..self.tiles.len();
        let mut r_height_rng = height_rng.clone();
        let mut row_rng      = 0..self.tiles[0].len();
        let mut bot_row_rng  = row_rng.clone();

        /* Handle top border */
        for tx in row_rng {
            let mut s: Direction;
            if tx == 0 {
                /* S, E */
                let d: [Direction; 2] = [S, E];
                s = rand_direction_from_arr(&d);
            }
            else if tx == row_max {
                /* S, W */
                let d: [Direction; 2] = [S, W];
                s = rand_direction_from_arr(&d);
            }
            else {
                /* S, W, E */
                let d: [Direction; 3] = [S, W, E];
                s = rand_direction_from_arr(&d);
            }

            let (nx, ny) = Board::move_to(s);

            if self.tiles[0][tx] > 0 {
                self.tiles[0][tx]       -= 1; /* old cell -1 */
                self.tiles[0+ny][tx+nx] += 1; /* new cell +1 */
            }
        }


        /* Handle bottom border */
        for bx in bot_row_rng {
            let mut s: Direction;
            if bx == 0 {
                /* S, E */
                let d: [Direction; 2] = [N, E];
                s = rand_direction_from_arr(&d);
            }
            else if bx == row_max {
                /* S, W */
                let d: [Direction; 2] = [N, W];
                s = rand_direction_from_arr(&d);
            }
            else {
                /* S, W, E */
                let d: [Direction; 3] = [N, W, E];
                s = rand_direction_from_arr(&d);
            }

            let (nx, ny) = Board::move_to(s);
            let max_height_ix: u32 = height_max;

            if self.tiles[max_height_ix][bx] > 0 {
                self.tiles[max_height_ix as usize ][bx as usize]       -= 1; /* old cell -1 */
                self.tiles[max_height_ix+ny as usize][bx+nx as usize] += 1; /* new cell +1 */
            }
        }

        /* Handle left border */
        for y in height_rng {
            let mut s: Direction;
            if y == 0 {
                let d: [Direction; 2] = [S, E];
                s = rand_direction_from_arr(&d);
            }
            else if y == height_max as usize {
                let d: [Direction; 2] = [N, E];
                s = rand_direction_from_arr(&d);
            }
            else {
                let d: [Direction; 3] = [S, E, N];
                s = rand_direction_from_arr(&d);
            }

            let (nx, ny) = Board::move_to(s);

            if self.tiles[y as usize][0] > 0 {
                self.tiles[y as usize][0]       -= 1;
                self.tiles[(y+ny) as usize][0+nx as usize] += 1;
            }
        }

        /* Handle right border */
        for y in r_height_rng {
            let mut s: Direction;
            if y == 0 {
                let d: [Direction; 2] = [S, W];
                s = rand_direction_from_arr(&d);
            }
            else if y == height_max {
                let d: [Direction; 2] = [N, W];
                s = rand_direction_from_arr(&d);
            }
            else {
                let d: [Direction; 3] = [S, W, N];
                s = rand_direction_from_arr(&d);
            }

            let (nx, ny) = Board::move_to(s);
            let mx = row_max;

            if self.tiles[y as usize][mx as usize] > 0 {
                self.tiles[y as usize][mx as usize]       -= 1;
                self.tiles[(y+ny) as usize][(mx+nx) as usize] += 1;
            }
        }

        /* Handle inner range (everything but borders) */
        for y in 1..height_max {
            for x in 1..row_max {
                let d: Direction = random_direction();
                let (nx, ny) = Board::move_to(d);
                if self.tiles[y as usize][x as usize] > 0 {
                    self.tiles[y as usize][x as usize] -= 1;
                    self.tiles[(y+ny) as usize][(x+nx) as usize] += 1;
                }
            }
        }
    }

    fn move_to(d: Direction) -> (u32,u32) {
        match d {
            N => (0, -1),
            S => (0,  1),
            E => (1, 0),
            W => (-1,  0),
        }
    }

    fn row_max(&self) -> u32 { self.tiles.len() as u32 }

    fn height_max(&self) -> u32 { self.tiles.len() as u32 }

    pub fn print(&self) {
        println!("==[Step {}]==", self.step);
        for y in self.tiles.iter() {
            for x in y.iter() {
                print!("{:^3} ", x);
            }
            println!("");
        }
    }

}

