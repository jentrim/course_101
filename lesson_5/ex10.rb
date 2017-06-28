arr = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]
new_arr = []

arr.map do |hsh|
  sub_hash = {}
  hsh.each{ |k,v | sub_hash[k] = v + 1 }
  new_arr.push(sub_hash)
end

p new_arr
p arr