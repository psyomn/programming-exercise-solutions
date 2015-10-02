extern crate rand;

use rand::Rng;

pub fn random_password(x: u32, y: u32) -> String {
    let mut rng = rand::thread_rng();
    let xusize = x as usize;
    let mut c : String = String::new();

    for _ in 0..y {
        c = c + &rng
            .gen_ascii_chars()
            .take(xusize)
            .collect::<String>()
            + "\n";
    }

    c
}
