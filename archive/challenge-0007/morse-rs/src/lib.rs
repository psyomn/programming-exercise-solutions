use std::collections::HashMap;

static ALPHABET: [&'static str; 37] = [
    "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K",
    "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
    "W", "X", "Y", "Z", "1", "2", "3", "4", "5", "6", "7",
    "8", "9", "0", " "];

static MORSE_ARR: [&'static str; 37] = [
    ".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---",
    "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-",
    "..-", "...-", ".--", "-..-", "-.--", "--..", ".----", "..---", "...--",
    "....-", ".....", "-....", "--...", "---..", "----.", "-----", "/"];

pub fn make_alpha_hash() -> HashMap<String, String> {
    let mut morse: HashMap<String, String> = HashMap::new();
    let mut a_it = ALPHABET.iter();
    let mut m_it = MORSE_ARR.iter();

    loop {
        let a_v = a_it.next();
        let m_v = m_it.next();

        match m_v {
            Some(v) => {
                match a_v {
                    Some(vv) => {
                        morse.insert(v.to_string(), vv.to_string());
                    },
                    None => {
                        break;
                    },
                }
            },
            None => {
                break;
            }
        }
    }

    morse
}

pub fn make_morse_hash() -> HashMap<String, String> {
    let mut morse: HashMap<String, String> = HashMap::new();

    let mut a_it = ALPHABET.iter();
    let mut m_it = MORSE_ARR.iter();

    loop {
        let a_v = a_it.next();
        let m_v = m_it.next();

        match a_v {
            Some(v) => {
                match m_v {
                    Some(nv) => {
                        morse.insert(v.to_string(), nv.to_string());
                    }
                    None => {
                        break;
                    }
                }
            },
            None => {
                break;
            }
        }
    }

    morse
}

/// Expects to give in parameters of morse separated by whitespace.
/// returns a list of letters
pub fn morse_to_ascii(morse: String) -> String {
    let alpha: HashMap<String,String> = make_alpha_hash();
    let signals: Vec<&str> = morse.split(" ").collect::<Vec<&str>>();
    let mut ret: String = String::new();

    for c in signals.iter() {
        let cc: &str = c.as_ref();
        match alpha.get(cc) {
            Some(v) => { ret = ret + &v.to_string(); },
            None => {},
        }
    }

    return ret;
}

/// Expects to be given a string of characters - a phrase; 
/// returns a list of morse codes in string format
pub fn ascii_to_morse(ascii: String) -> String {
    let morse: HashMap<String,String> = make_morse_hash();
    let chars: Vec<&str> = ascii.split("").collect::<Vec<&str>>();
    let mut ret: String = String::new();

    for c in chars {
        match morse.get(c) {
            Some(v) => { ret = ret + &v + " "},
            None => {},
        }
    }

    return ret;
}

