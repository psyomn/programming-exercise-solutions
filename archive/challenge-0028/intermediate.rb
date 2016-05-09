# This is very inefficient. migth tweak and optimize later

def tet(n)
  (n * (n + 1) * (n + 2))/ 6
end

def tet_seq(k)
  (1..k).to_a.map { |e| [e, tet(e)] }
end

def find_n(seq, n)
  seq.each do |e,v|
    next if n != v
    return e
  end
  nil
end

input = $stdin.gets.to_i

puts find_n(tet_seq(input), input)

