use std::io;

#[derive(Debug)]
struct Employee {
    name: String,
    age: u16,
    rate: f32,
}

impl Employee {
    pub fn from_line(line: &String) -> Employee {
        let mut iter = line.split(',').map(|e| e.trim());

        let name = iter.next().expect("it should specify a name");
        let age_str = iter.next().expect("it should specify a name");
        let rate_str = iter.next().expect("it should specify a name");

        let age = age_str.parse::<u16>().expect("not a number");

        let cleaned_rate: f32 = rate_str
            .chars()
            .into_iter()
            .filter(|e| acceptable_char(*e))
            .collect::<String>()
            .parse::<f32>()
            .expect("not a float");

        Employee {
            name: name.into(),
            age: age,
            rate: cleaned_rate,
        }
    }
}


fn main() -> () {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();
    println!("{:?}", Employee::from_line(&s));
}

fn acceptable_char(c: char) -> bool {
    let accept = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];

    for ac in accept.into_iter() {
        if *ac == c { return true }
    }

    false
}
