fn main() -> () {
    // Madhava-Liebniz series, for pi approx

    let c: f64 = 12.0;
    let sqrt_c = c.sqrt();
    let mut result: f64 = 0.0;
    let ccc: f64 = -3.0;

    for k in 0..21 {
        result += (ccc).powf(-k as f64) / (2 * k + 1) as f64;
    }

    result *= sqrt_c;

    println!("{}", result);
}
