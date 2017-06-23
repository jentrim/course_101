letter_count = Hash.new(0)
statement = "The Flintstones Rock"
statement.delete(' ').chars.each do |letter|
  letter_count[letter] += 1
end

p letter_count
