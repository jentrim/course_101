# request numbers

puts "Please enter the first number"
x = gets.chomp.to_i
puts "Please enter the second number"
y = gets.chomp.to_i

# request operator
puts "Which operation would you like to perform?\nEnter: \n  + to add \n  - to subtract\n  x to multiply\n  / to divide"
operator = gets.chomp

# perform operation and report result
case operator
when '+' then puts x + y
when '-' then puts x - y
when 'x' then puts x * y
when '/' then puts x.to_f / y.to_f
end
