use player;
use player::GameChoice;

pub struct Arena<'a, 'b> {
    player_one: &'a mut player::Player,
    player_two: &'b mut player::Player,
}

impl<'a, 'b> Arena <'a, 'b>  {

    pub fn new(p1: &'a mut player::Player, p2: &'b mut player::Player) -> Arena {
        Arena { player_one: p1, player_two: p2 }
    }

    pub fn step(&mut self) {
        match (self.player_one.draw(), self.player_two.draw()) {
            (player::GameChoice::Rock,    player::GameChoice::Paper)   => self.player_two.win(),
            (player::GameChoice::Paper,   player::GameChoice::Rock)    => self.player_one.win(),

            (player::GameChoice::Paper,   player::GameChoice::Scissor) => self.player_two.win(),
            (player::GameChoice::Scissor, player::GameChoice::Paper)   => self.player_one.win(),

            (player::GameChoice::Rock,    player::GameChoice::Scissor) => self.player_one.win(),
            (player::GameChoice::Scissor, player::GameChoice::Rock)    => self.player_two.win(),

            (_, _)             => ()
        }
    }

}


