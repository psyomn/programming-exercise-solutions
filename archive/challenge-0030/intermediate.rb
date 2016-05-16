# luhn algorithm for digit checks
def luhn(number)
  last_digit = number % 10
  num = number / 10
  arr = []
  toggle = false

  until num == 0 do
    val = if toggle = !toggle
            2 * (num % 10)
          else
            (num % 10)
          end

    arr.push val

    num /= 10
  end

  arr.map! { |el| el > 9 ? (el%10) + (el/10) : el }

  p last_digit
  p arr
  arr.inject(0) { |el, sum| el + sum } + last_digit
end

def is_valid(number)
  luhn(number) % 10 == 0
end

puts "valid number? #{is_valid(gets.to_i)}"

