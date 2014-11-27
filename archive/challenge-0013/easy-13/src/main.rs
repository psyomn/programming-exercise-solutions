use std::os;

fn main() {
  let mut args: Vec<String> = os::args();
  let cal:  [(&str, uint), ..12] = [
      ("january"  ,  31), ("february" ,  28),
      ("march"    ,  29), ("april"    ,  30),
      ("may"      ,  31), ("june"     ,  30),
      ("july"     ,  31), ("august"   ,  31),
      ("september",  30), ("october"  ,  31),
      ("november" ,  30), ("december" ,  31),
      ];

  if args.len() != 3 {
      println!("Usage:");
      println!("  easy-13 <month> <day>");
      return;
  }

  let day_of_month = match args.pop() {
      Some(String) => String,
      _            => "wrong month".to_string(),
  };

  let month : String = match args.pop() {
      Some(String) => String,
      _            => "wrong month".to_string(),
  };

  let month_exists: bool = cal.iter().fold(false, |acc, e| acc || cmp_cal(e, month));

  println!("{}", month);
}

fn cmp_cal(tuple: &(&str, uint), month: String) -> bool {
  let &(m, d) = tuple;
  return m.to_string() == month;
}

