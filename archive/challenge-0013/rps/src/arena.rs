use player;
pub use player::GameChoice::{Rock, Paper, Scissor};

pub struct Arena<'a> {
    player_one: &'a mut player::Player,
    player_two: &'a mut player::Player,
}

impl<'a> Arena <'a>  {

    pub fn new(p1: &'a mut player::Player, p2: &'a mut player::Player) -> Arena<'a> {
        Arena { player_one: p1, player_two: p2 }
    }

    pub fn step(&mut self) {
        match (self.player_one.draw(), self.player_two.draw()) {
            (Rock,    Paper)   => self.player_two.win(),
            (Paper,   Rock)    => self.player_one.win(),

            (Paper,   Scissor) => self.player_two.win(),
            (Scissor, Paper)   => self.player_one.win(),

            (Rock,    Scissor) => self.player_one.win(),
            (Scissor, Rock)    => self.player_two.win(),

            (_, _)             => ()
        }
    }

    pub fn print_scores(&mut self) {
        println!("-- Current Scoreboard -- ");
        self.player_one.print();
        self.player_two.print();
    }

}


