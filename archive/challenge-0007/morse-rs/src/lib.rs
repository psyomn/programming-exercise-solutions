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

        match m_v {
            Some(v) => {
                match a_v {
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
fn morse_to_ascii(morse: String) -> String {
    return "todo".to_string();
}

/// Expects to be given a string of characters - a phrase; 
/// returns a list of morse codes
fn ascii_to_morse(ascii: String) -> String {
    return "todo".to_string();
}

