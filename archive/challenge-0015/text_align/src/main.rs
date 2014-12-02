use std::io::File;

/// Iterate through all the lines in a text chunk, and find the max characters
/// found on a line.
fn max_line_size(v: &Vec<u8>) -> u64 {
    let mut count: u64 = 0;
    let mut max: u64 = 0;
    let line_delimeters : [u8, ..2] = ['\r' as u8, '\n' as u8];

    for x in v.iter() {
        if line_delimeters.contains(x) {
            max = if max < count { count } else { max };
            count = 0;
        }
        else {
            count = count + 1;
        }
    }

    return max;
}

/// Depending on the line size, we'll print a bunch of whitespace before
/// printing the rest of the line.
fn pad_line(line: &Vec<u8>, max: u64) {
    let line_size = line.len() as u64;
    let diff = max - line_size;

    if diff > 0 {
        for x in range(1, diff) {
            print!(" ");
        }
    }

    print!("{}", line);
}

fn main() {
    let f_res        = File::open(&Path::new("textfile.txt")).read_to_end();
    let res: Vec<u8> = f_res.ok().unwrap(); /* TODO how do we handle errors? */
    let max: u64     = max_line_size(&res);

    for x in res.split(|a| (*a == '\n' as u8 || *a == '\r' as u8) ) {
        let curr_line: Vec<u8> = (*x).iter().map(|&x| x).collect();
        pad_line(&curr_line, max);
    }
}
