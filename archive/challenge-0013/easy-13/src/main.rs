use std::os;

fn main() {
  let mut args: Vec<String> = os::args();
  let cal:  [(&str, uint), ..12] = [
      ("january"  ,  31), ("february" ,  28),
      ("march"    ,  31), ("april"    ,  30),
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

  let day_of_month_opt : Option<uint> = from_str(day_of_month.as_slice());

  let day_of_month_i = match day_of_month_opt {
      Some(uint)   => uint,
      _            => 0u,
  };

  let month : String = match args.pop() {
      Some(String) => String,
      _            => "wrong month".to_string(),
  };

  let month_exists: bool = cal.iter().fold(false, |acc, e| acc || cmp_cal(e, &month));

  if !month_exists {
      println!("{} is not a proper month", month);
      return;
  }

  /* Finally count the days; we add the day of month, and add previous months maxes */
  let mut total_days: uint = day_of_month_i;
  let mut last_acc:   uint = 0;

  for m in cal.iter() {
      let &(derp, acc) = m;
      last_acc = acc;

      if derp.to_string() == month { break }
      total_days += acc;
  }

  /* Is the day the user entered in the month range? */
  if !(day_of_month_i <= last_acc && day_of_month_i > 0) {
      println!("Bad input: {}; max day of {} is {}",
               day_of_month, month, last_acc);
      return;
  }

  println!("Day of year for <{}> <{}> is: {}", month, day_of_month, total_days);

}

fn cmp_cal(tuple: &(&str, uint), month: &String) -> bool {
  let &(m, d) = tuple;
  return m.to_string() == *month;
}

