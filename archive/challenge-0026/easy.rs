fn main() -> () {
    let test: String = "hahahahah".into();
    let test2: String = "HHAAHHAAHHAAHHAA".into();

    println!("{:?}", str_to_tup(&test));
    println!("{:?}", str_to_tup(&test2));
}

fn str_to_tup(input: &String) -> (String, String) {
    let mut c: char = ' ';
    let mut iter = input.chars();
    let mut one_str = String::new();
    let mut dup_str = String::new();

    c = iter.next().unwrap();
    one_str.push(c);

    while let Some(cc) = iter.next() {
        if cc == c {
            dup_str.push(cc);
        }
        else {
            one_str.push(cc);
        }
        c = cc;
    }

    (one_str, dup_str)
}
