arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
arr.sort_by do |subarr|
  subarr.select{|int| int.odd?}
end
