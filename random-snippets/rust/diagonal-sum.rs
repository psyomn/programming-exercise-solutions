use std::io;

fn input_size() -> usize {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();
    let ret = s.trim().parse::<usize>().unwrap();
    ret
}

fn main() -> () {
    let input_num = input_size();
    let mut s = String::new();
    let mut matrix: Vec<i32> = Vec::new();

    for _ in 0..input_num {
        s.clear();
        io::stdin().read_line(&mut s).unwrap();

        let row: Vec<i32> = s
            .split_whitespace()
            .map(|e| e.parse::<i32>().unwrap())
            .collect();

        matrix.extend_from_slice(&row);
    }

    let offset = input_num - 1;

    let diag_ld_coords: Vec<(usize,usize)> =
        (0..input_num)
        .map(|e| (e, e))
        .collect();

    let diag_rd_coords: Vec<(usize,usize)> =
        (0..input_num)
        .map(|e| (offset - e, e))
        .collect();

    let ld_sum = diag_ld_coords
        .iter()
        .fold(0, |sum, &(x, y)| sum + matrix[input_num*y+x]);

    let rd_sum = diag_rd_coords
        .iter()
        .fold(0, |sum, &(x, y)| sum + matrix[input_num*y+x]);

    let delta = (ld_sum - rd_sum).abs();

    println!("{}", delta);
}
