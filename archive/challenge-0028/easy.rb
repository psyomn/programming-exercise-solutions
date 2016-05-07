arr = (1..10).to_a

sample = (1..100).to_a.map { arr.sample }

grouped = sample.group_by { |e| e }
filtered = grouped.select { |k,v| v.count > 1 }.map { |k,v| v }

p filtered

