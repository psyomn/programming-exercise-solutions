num_1 = $stdin.gets.strip
num_2 = $stdin.gets.strip

number_1_26_i = num_1.tr('a-z', '0-9a-p').to_i(26)
number_2_26_i = num_2.tr('a-z', '0-9a-p').to_i(26)

k = number_1_26_i * number_2_26_i

puts k.to_s(26).tr('0-9a-p', 'a-z')
