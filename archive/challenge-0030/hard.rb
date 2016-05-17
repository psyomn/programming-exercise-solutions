n = $stdin.gets.to_i
golden_ratio = (1 + Math.sqrt(5)) / 2.0
puts ((((golden_ratio) ** n) / Math.sqrt(5)) + 0.5).floor
