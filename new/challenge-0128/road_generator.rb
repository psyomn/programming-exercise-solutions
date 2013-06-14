#!/usr/bin/env ruby

size = ARGV[0].to_i || 6
puts size
size.times do 
    puts ([0..9] * size).collect{|e| e.to_a.sample}.join(' ').concat("\n")
end
