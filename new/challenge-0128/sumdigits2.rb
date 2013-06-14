#!/usr/bin/env ruby
a = $stdin.gets.split('').collect{|o| o.to_i}.inject(&:+)
until a < 10
 a = a.to_s.split('').collect{|o| o.to_i}.inject(&:+)
 puts a
end
