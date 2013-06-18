#!/usr/bin/env ruby
# Author :: Simon Symeonidis
# URI    :: http://www.reddit.com/r/dailyprogrammer/comments/1g7gyi
# This script assumes an n*n matrix.
require 'matrix'

# This is a necessary evil. Matrix class is useless otherwise
# Thanks to http://www.ruby-forum.com/topic/161792#710996
class Matrix
  def []=(i,j,x); @rows[i][j] = x; end
  def to_s; @rows.collect.inject(""){|s,e| s.concat("#{e.join(' ')}\n")}; end
end

def goal_reached?(mx)
  rank(mx).select{|e| e[3] > 0}.count == 0
end

def rank(mx)
  (mx.column_vectors.collect.with_index{|e,i| [:col, i, e]} +
      mx.row_vectors.collect.with_index{|e,i| [:row, i, e]})
    .collect{|el| el << el[2].select{|e| e <= 0}.count}
    .sort!{|x,y| y[3] <=> x[3]}
end

def fix(mx,ix,direction)
  meth = direction == :col ? :column_vectors : :row_vectors
  mx.send(meth).first.count.times do |x|
    x, y = [x, ix]
    mx[x,y] = 1 if mx[x,y] <= 0 and direction == :col
    mx[y,x] = 1 if mx[y,x] <= 0 and direction == :row
  end
end

def main_loop(mx)
  steps = 0
  until goal_reached? (mx) do
    t = rank(mx).first
    fix(mx,t[1],t[0]) 
    steps += 1
  end
  steps
end

data = Array.new
$stdin.gets.chomp!.to_i.times do
  data.push $stdin.gets.split.collect{|o| o.to_i}
end

mx = Matrix[*data]
steps = main_loop(mx)

puts mx
puts "Steps: #{steps}"
