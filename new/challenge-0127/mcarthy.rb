# Author :: Simon Symeonidis
# URL    :: http://www.reddit.com/r/dailyprogrammer/comments/1f7qp5/
puts "M(#{n = $stdin.gets.to_i})"
until n == 91 do
  puts n <= 100 ? "M(M(%d)) since %d is equal to or less than 100" % [n+11,n]
                : "M(%d) because %d is greater than 100" % [n-10,n]
  n = n <= 100 ? n + 11 : n - 10 
end
puts $_ # just to piss people off :D
