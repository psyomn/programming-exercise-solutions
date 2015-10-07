extern crate arrr_rust;

use arrr_rust::{Pirate, PirateBuilder, PirateArena};

fn main() {
    let blackbeard: Pirate =
        PirateBuilder::new()
            .name("Blackbeard".to_string())
            .attack(4)
            .defense(4)
            .finalize();

    let redbeard: Pirate =
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
