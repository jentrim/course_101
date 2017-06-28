arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

multiples = arr.map do |sub_arr|
  sub_arr.select{|n| n % 3 == 0 }
end

p multiples