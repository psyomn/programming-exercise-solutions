require 'set'
# URL    :: http://www.reddit.com/r/dailyprogrammer/comments/1g09qy
# Author :: Simon Symeonidis
# Note   :: Not finished yet.

# Ruby 2.x
module MyEvilThings
  refine Array do
    def longest_chain
      day  = max_forwards_day
      max_forwards = self.select{|o| o[2].include? day}
      count = 0
      max_forwards.each do |mf|
      end
      count
    end

    def max_forwards_day
      arr = (1..(self.collect{|a| a[2].max}.max))
            .collect{|t| [t, self.total_forwards(t)]}
      arr.sort!{|x,y| y[1]<=>x[1]}.first.first
    end
    def total_forwards(day) self.select{|r| r[2].include? day}.count; end
  end
end

using MyEvilThings

num_of_entries = $stdin.gets.chomp!.to_i
forwards       = Array.new

num_of_entries.times do
  phone_from, phone_to, start, dur = $stdin.gets.chomp!.split(/\s+/)
  forwards.push [phone_from, phone_to, (start.to_i)..(start.to_i + dur.to_i)]
end

puts forwards.total_forwards($stdin.gets.chomp!.to_i)
puts forwards.longest_chain
