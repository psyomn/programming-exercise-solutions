mod arena;
mod player;


fn main() {
    let mut p1 = player::Player::new("jonny".to_string());
    let mut p2 = player::Player::new("joe".to_string());

    p2.weight(1);

    let mut arena = arena::Arena::new(&mut p1, &mut p2);

    println!("Simulating tournaments ...");

    for x in range(0i, 100000i) {
      arena.step();
    }

    arena.print_scores();
}
