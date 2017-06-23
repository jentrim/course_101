flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
h = {}
flintstones.each_with_index do |name, index|
  h[name] = index
end

puts h
  