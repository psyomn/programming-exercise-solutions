fn main() -> () {
    let max: u16 = 2000;
    let mut primes = vec![2];

    for n in 3..max {
        let divides = primes
            .iter()
            .map(|e| { n % e == 0 })
            .fold(false, |e,sum| e || sum);

        if divides { continue } else { primes.push(n) }
    }

    println!("{:?}", primes);
}
