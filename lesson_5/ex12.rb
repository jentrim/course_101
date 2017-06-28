arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]

arr.each_with_object({}) do |sub_arr, hsh|
  hsh[sub_arr[0]] = sub_arr[1]
end

