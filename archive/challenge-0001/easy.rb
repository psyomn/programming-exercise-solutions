#!/usr/bin/env ruby
# http://www.reddit.com/r/dailyprogrammer/comments/pih8x/
arr = ["name : ","age : ","redditname : "].collect{|e| print e; $stdin.gets.chomp!}
puts "your name is %s, you are %s years old, and your username is %s" % arr


