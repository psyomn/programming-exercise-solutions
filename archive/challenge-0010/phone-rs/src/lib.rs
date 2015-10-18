extern crate regex;

use regex::Regex;

pub fn valid_phone(phone: &str) -> bool {
    vcheck1(phone) || vcheck2(phone) || vcheck3(phone)
}

pub fn vcheck1 (s: &str) -> bool {
    let re0: Regex = Regex::new(r"\d{10}").unwrap();
    re0.is_match(s)
}

pub fn vcheck2 (s: &str) -> bool {
    let re1: Regex = Regex::new(r"(\d{3}[-.]){2}\d{4}").unwrap();
    re1.is_match(s)
}

/// Detect these formats:
///   (123)456-7890,
///   (123) 456-7890 (note the white space following the area code),
///   and 456-7890
pub fn vcheck3 (s: &str) -> bool {
    let first_three_or_not: &str = r"((\(\d{3}\))(\s?))?";
    let last_part: &str = r"(\d{3}-\d{4})";
    let complete: String = format!("{}{}", first_three_or_not, last_part);
    let re2: Regex = Regex::new(complete.as_ref()).unwrap();
    re2.is_match(s)
}

/// Just ignore this. 
pub fn parenthesis_check() -> bool {
    let re: Regex = Regex::new(r"\(a\)").unwrap();
    re.is_match("(a)")
}


#[cfg(test)]
mod test {
    use super::*;
    #[test]
    fn test_10_digit() -> () {
        assert!(valid_phone("1111111111"));
        assert!(valid_phone("1242451431"));
    }

    #[test]
    /// expect fail
    fn test_5_digit() -> () {
        assert_eq!(valid_phone("11111"), false);
    }

    #[test]
    fn test_dashed() -> () {
        assert!(valid_phone("111-111-1111"));
    }

    #[test]
    fn test_dotted() -> () {
        assert!(valid_phone("111.111.1111"));
    }

    #[test]
    fn test_parenthesis_nospace() -> () {
        assert!(valid_phone("(123)123-1231"));
    }

    #[test]
    fn test_parenthesis_space() -> () {
        assert!(valid_phone("(123) 123-1231"));
    }

    #[test]
    fn test_parenthesis_space_badnum() -> () {
        assert_eq!(valid_phone("(1234) 123-1313"), false);
    }

    #[test]
    fn test_parenthesis_more_space_vcheck1() -> () {
        assert_eq!(vcheck1("(123)    123-1231"), false);
    }
    #[test]
    fn test_parenthesis_more_space_vcheck2() -> () {
        assert_eq!(vcheck2("(123)    123-1231"), false);
    }

    #[test]
    fn test_parenthesis_more_space_vcheck3() -> () {
        assert_eq!(vcheck3("(123)    123-1231"), false);
    }

    #[test]
    fn test_smallnum() -> () {
        assert!(valid_phone("123-1231"));
    }

    #[test]
    fn test_smallnum_bad() -> () {
        assert_eq!(valid_phone("123-123"), false);
    }

    #[test]
    fn test_smallnum_bad_2() -> () {
        assert_eq!(valid_phone("12-12"), false);
    }

    #[test]
    fn test_smallnum_bad_3() -> () {
        assert_eq!(valid_phone("-1"), false);
    }

    #[test]
    fn test_smallnum_bad_4() -> () {
        assert_eq!(valid_phone("1-1"), false);
    }

    #[test]
    fn test_smallnum_bad_5() -> () {
        assert_eq!(valid_phone("1-"), false);
    }

    #[test]
    fn test_parenthesis_regex() -> () {
        assert!(parenthesis_check());
    }
}

