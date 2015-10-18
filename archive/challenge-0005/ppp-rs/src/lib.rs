extern crate regex;

use std::fs::File;
use std::io::Read;
use regex::Regex;

static USERLIST_FILE: &'static str = "users.txt";

#[derive(Debug)]
pub struct User {
    name: String,
    pass: String,
}

impl User {
    pub fn new(n: String, p: String) -> User {
        User {
            name: n,
            pass: p,
        }
    }

    pub fn authenticate(&self, p: String) -> bool {
        self.pass == p
    }
}

fn read_file_contents() -> String {
    let mut f: File = match File::open(::USERLIST_FILE) {
        Ok(vf) => vf,
        Err(e) => panic!(e),
    };
    let mut s: String = String::new();
    f.read_to_string(&mut s).unwrap();
    s
}

fn find_user(username: String) -> Option<User> {
    let re: Regex = Regex::new(r"([:alnum:]+):([:alnum:]+)").unwrap();
    let re_find: Regex = Regex::new(username.as_ref()).unwrap();
    let contents: String = read_file_contents();
    let user_row: &str =
        contents
            .split('\n')
            .filter(|e| { re.is_match(e) && re_find.is_match(e) })
            .nth(0)
            .unwrap_or("");

    if user_row == "" {
        return None;
    }

    let group = match re.captures_iter(user_row).next() {
        None => return None,
        Some(v) => v
    };

    let found_username: String = group.at(1).unwrap_or("").to_string();
    let found_password: String = group.at(2).unwrap_or("").to_string();

    Some(User {
        name: found_username,
        pass: found_password,
    })
}

pub fn attempt_authentication(given_user: String, given_password: String) -> bool {
    let user = match find_user(given_user) {
        None => return false,
        Some(v) => v,
    };

    user.pass == given_password
}
