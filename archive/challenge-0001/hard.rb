#!/usr/bin/env ruby
# Author :: Simon Symeonidis
# URL    :: http://www.reddit.com/r/dailyprogrammer/comments/pii6j

win = false 
num_range = (1..100)

until win do
  puts "#{current = num_range.to_a.sample}?"
  case $stdin.gets.chomp!
  when "higher"  then num_range = (current + 1)..num_range.max
  when "lower"   then num_range = num_range.min..(current - 1)
  when "correct" then win = true end
end

