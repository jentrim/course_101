def generate_UUID
  choices = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
  hyphen_indices = [8, 13, 18, 23]
  digits = ''
  
  32.times{digits << (choices.sample)}
  hyphen_indices.each{|index| digits.insert(index, '-')}
  digits
end

puts generate_UUID