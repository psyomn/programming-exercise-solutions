use std::io::File;

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

fn main() {
    let f_res = File::open(&Path::new("textfile.txt")).read_to_end();
    let res: Vec<u8>  = f_res.ok().unwrap(); /* TODO how do we handle errors? */

}
