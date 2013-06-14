#!/usr/bin/env ruby
# Uri    :: http://www.reddit.com/r/dailyprogrammer/comments/1g0tw1/
# Author :: Simon Symeonidis
charbuff               = []
current_string, result = String.new, String.new

$stdin.gets.chomp!.chars do |c| 
  charbuff.push c unless charbuff.member? c
  if charbuff.size > 2
    charbuff = charbuff.drop(1)
    current_string.gsub!(/[^#{charbuff.first}]/, '')
  end
  current_string.concat(c)
  result = current_string.dup if result.length < current_string.length
end

puts result

