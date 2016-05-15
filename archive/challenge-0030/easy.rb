vec = gets.split.map(&:to_i)
num = gets.to_i

until vec.empty? do
  curr = vec.pop
  vec.each do |el|
    next if curr + el != num
    puts "#{curr} + #{el} == #{num}"
    exit 0
  end
end

puts "Nothing found"
exit 2

