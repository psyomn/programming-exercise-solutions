use std::fmt;

fn main() -> () {
    let game_map: GameMap = GameMap::new();
    let mut player_coords = Point { x: 1, y: 1 };

    println!("{}", game_map);

    println!("{:?}", player_coords);

    println!("The above coordinates are: {:?}", game_map.at(player_coords));
}

#[derive(Debug)]
struct GameMap {
    grid: Vec<Vec<char>>,
}

#[derive(Debug)]
struct Point {
    x: usize,
    y: usize,
}

impl GameMap {
    pub fn new() -> GameMap {
        let max_size = 20;
        let mut ret: Vec<Vec<char>> = Vec::new();

        for _ in 0..max_size {
            let mut row = Vec::new();
            for _ in 0..max_size {
                row.push('#');
            }
            ret.push(row);
        }

        GameMap {
            grid: ret
        }
    }

    pub fn width(&self) -> usize {
        self.grid[0].len()
    }

    pub fn height(&self) -> usize {
        self.grid.len()
    }

    pub fn set_at(&mut self, p: Point, value: char) -> Result<(), String> {
        let Point { x: x, y: y } = p;
        let tile = self.grid
                       .get_mut(y)
                       .unwrap()
                       .get_mut(x);
        match tile {
            Some(v) => {
                Ok(())
            },
            None => Err("Problem finding those coordinates".into())
        }
    }

    pub fn at(&self, p: Point) -> MapItem {
        let Point { x: at_x, y: at_y } = p;

        let curr_point =
            self.grid.get(at_y)
                     .map(|row| row.get(at_x));

        match curr_point {
            None => return MapItem::OutOfBounds,
            Some(v) => {
                if let Some(chr) = v {
                    match *chr {
                    '#' => MapItem::Wall,
                    ' ' => MapItem::Empty,
                      _ => MapItem::BadChar,
                    }
                }
                else {
                    MapItem::OutOfBounds
                }
            }
        }
    }
}

struct GameMazeBuilder;
impl GameMazeBuilder {
    pub fn random(g: GameMap) -> GameMap {
        g
    }
}

#[derive(Debug)]
enum MapItem {
    Wall,
    Empty,
    Exit,
    BadChar,
    OutOfBounds,
}

impl fmt::Display for GameMap {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        let grid = &self.grid;

        for row in grid {
            for el in row {
                write!(f, "{}", el).unwrap();
            }
            write!(f, "\n").unwrap();
        }

        write!(f, "\n")
    }
}
