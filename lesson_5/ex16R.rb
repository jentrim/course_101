def make_uuid
  chars = %w(0 1 2 3 4 5 6 7 8 9 a b c d e f)
  uuid = []

  section_sizes = [8, 4, 4, 4, 12]
  section_sizes.each do |section|
    result = ''
    section.times{result << chars.sample}
    uuid.push(result)
  end
  
  uuid.join('-')
end

puts make_uuid