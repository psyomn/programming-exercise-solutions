use std::os;

fn main() {
    let vals: Vec<String> = os::args();

    if (vals.len() < 3) {
        /* Make sure that we get anough parameters; rest is ignored */
        println!("Usage:");
        println!("  replace_str <main-string> <replace-char>+");
        return;
    }

    let data: String = vals[1].clone(); // vals[0] is program name
    let to_rm: String = vals[2].clone();

    let test = vals[2].as_slice().contains("a");
    let mut result_iter = data.as_slice().graphemes(true).filter(|a| !to_rm.as_slice().contains(*a));

    for x in result_iter {
        print!("{}", x);
    }
    println!("");
}
