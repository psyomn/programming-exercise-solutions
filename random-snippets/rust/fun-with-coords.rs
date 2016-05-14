use std::io;

const HGLASS_COORDS: [(usize, usize); 7] =
    [(0, 0), (1, 0), (2, 0),
             (1, 1),
     (0, 2), (1, 2), (2, 2)];

fn main() ->  () {
    let mut s = String::new();
    let mut matrix: Vec<Vec<i32>> = Vec::new();

    io::stdin().read_line(&mut s).unwrap();

    let num = num_input(&s);
    matrix.push(parse_line(&s));

    for _ in 0..num {
        s.clear();
        io::stdin().read_line(&mut s).unwrap();
        matrix.push(parse_line(&s));
    }

    // minus 1 because hglass dims
    let max_iter = num - 1;
    let mut max_val: i32 = sum_coordinates(&matrix, HGLASS_COORDS, (0,0));

    for y in 0..max_iter {
        for x in 0..max_iter {
            let t = sum_coordinates(&matrix, HGLASS_COORDS, (x, y));
            max_val = if t > max_val { t } else { max_val };
        }
    }

    println!("{}", max_val);
}

fn num_input(s: &str) -> usize {
    s.split_whitespace().count() - 1
}

fn parse_line(line: &str) -> Vec<i32> {
    line
      .split_whitespace()
      .map(|e| e.parse::<i32>().unwrap())
      .collect()
}

fn sum_coordinates(m: &Vec<Vec<i32>>,
                   coords: [(usize, usize); 7],
                   offset: (usize, usize)) -> i32 {
    let (ox, oy) = offset;
    let coords_with_offset: Vec<(usize, usize)> =
        coords
          .iter()
          .map(|&(x,y)| (ox+x,oy+y))
          .collect();

    coords_with_offset
        .iter()
        .map(|&(x,y)| m[y][x])
        .fold(0, |sum,e| sum + e)
}
