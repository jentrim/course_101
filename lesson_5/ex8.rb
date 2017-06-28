hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |_, val| 
  val.each do |word|
    word.chars.each{|char| puts char if %w(a e i o u).include? char}
  end
end
    