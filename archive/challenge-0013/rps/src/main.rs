mod arena;
mod player;

fn main() {
    let mut p1 = player::Player::new("jonny".to_string());
    let mut p2 = player::Player::new("joe".to_string());
    let mut arena = arena::Arena::new(&p1, &p2);

    println!("First contenstant: ");
    p1.print();
    println!("");

    println!("Second contenstant: ");
    p2.print();
    println!("");

    println!("Simulating tournaments ...");
}
