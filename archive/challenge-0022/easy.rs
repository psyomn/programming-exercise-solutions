fn main() -> () {
    let v: Vec<u32> = vec![
        1,2,3,4
    ];

    let mut v2: Vec<u32> = vec![
        9,8,7,6
    ];

    for e in v {
        if !v2.contains(e) {
            v2.push(e);
        }
    }

    println!("Final Vector: {:?}", v2);
}

trait Containable<T: Eq> {
    fn contains(&self, T) -> bool;
}

impl<T: Eq> Containable<T> for Vec<T> {
    fn contains(&self, search_item: T) -> bool {
        for el in self {
            if search_item == *el {
                return true;
            }
        }
        false
    }
}
