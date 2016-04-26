fn main() -> () {
    let numvec: Vec<u32> = vec![1, 2, 3, 4, 5];
    let even_numvec: Vec<u32> = vec![1, 2, 3, 4, 5, 6];
    let fl_vec: Vec<f32> = vec![12.12, 13.13, 14.14, 15.15];
    let bool_vec: Vec<bool> = vec![true, false, true];
    let string_vec: Vec<String> = vec!["potato".into(), "potato".into(), "potato".into()];

    println!("{:?}", split_list::<u32>(numvec));
    println!("{:?}", split_list::<u32>(even_numvec));
    println!("{:?}", split_list::<f32>(fl_vec));
    println!("{:?}", split_list::<bool>(bool_vec));
    println!("{:?}", split_list::<String>(string_vec));
}

fn split_list<T: Clone>(v: Vec<T>) -> (Vec<T>, Vec<T>) {
    let mut one: Vec<T> = Vec::new();
    let mut two: Vec<T> = Vec::new();

    let len = v.len();

    match len % 2 {
        0 => {
            let half = len / 2;
            one.extend_from_slice(&v.as_slice()[0..half]);
            two.extend_from_slice(&v.as_slice()[half..half*2]);

            (one, two)
        },
        1 => {
            let half = len / 2;
            one.extend_from_slice(&v.as_slice()[0..half]);
            two.extend_from_slice(&v.as_slice()[(half)..(half*2+1)]);

            (one, two)
        },
        _ => {
            panic!("what just happened.");
        }
    }
}
