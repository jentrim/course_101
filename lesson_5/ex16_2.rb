def generate_UUID
  choices = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
  sections = [8, 4, 4, 4, 12]
  digits = ''
  
  sections.each do |section|
    section.times{digits << (choices.sample)}
    digits << '-' unless section == 12
  end
  digits
end

puts generate_UUID