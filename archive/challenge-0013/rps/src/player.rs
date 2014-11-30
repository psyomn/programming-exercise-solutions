use std::rand;
use std::rand::Rng;

pub struct Player {
    label:  String,
    score:  int,
    weight: int,
}

pub enum GameChoice { Rock, Paper, Scissor }

impl Player {

    pub fn new(name: String) -> Player {
        Player { label: name, score: 0, weight: 0, }
    }

    pub fn win(&mut self) {
        self.score += 1;
    }

    pub fn score(&mut self, s: int) {
        self.score = s;
    }

    pub fn weight(&mut self, s: int) {
        self.weight = s;
    }

    pub fn print(&self) {
        println!("Name  : {}", self.label);
        println!("Score : {}", self.score);
        println!("Weight: {}", self.weight);
    }

    pub fn draw(&self) -> GameChoice {
        let mut r = rand::task_rng();

        match r.gen::<int>() % 3 {
            0 => GameChoice::Rock,
            1 => GameChoice::Paper,
            2 => GameChoice::Scissor,
            _ => GameChoice::Rock,
        }
    }

}

