#!/usr/bin/env ruby
# Author :: Simon Symeonidis
# URL    :: http://www.reddit.com/r/dailyprogrammer/comments/1givnn/
a, b = $stdin.gets.chomp!.split('d').collect{|e| e.to_i}
a.times{ print "#{(1..b).to_a.sample} "}
puts
