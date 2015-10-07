extern crate arrr_rust;
extern crate rand;

use arrr_rust::{Pirate, PirateBuilder, PirateArena};
use rand::Rng;

fn main() {
    let mut blackbeard: Pirate =
        PirateBuilder::new()
            .name("Blackbeard".to_string())
            .attack(4)
            .defense(2)
            .finalize();

    let mut redbeard: Pirate =
        PirateBuilder::new()
            .name("Redbeard".to_string())
            .attack(8)
            .defense(5)
            .finalize();

    let mut arena: PirateArena = PirateArena::new(blackbeard, redbeard);

    while !arena.done() {
        arena.step();
        println!("{}", arena);
    }

    let winner: Option<&Pirate> = arena.winner();

    match winner {
        Some(v) => {
            println!("And the winner is... {}!!", v.get_name());
        },
        None => {
            println!("No winner - was the match finished?");
        },
    }

}
