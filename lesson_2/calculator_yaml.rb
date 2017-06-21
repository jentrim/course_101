require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

prompt(MESSAGES['welcome'])
# request numbers
loop do
  x = ''
  loop do
    prompt('Please enter the first number')
    x = Integer(gets) rescue false
    break unless x == false
    prompt('That is not a valid entry.')
  end

  y = ''
  loop do
    prompt('Please enter the second number')
    y = Integer(gets) rescue false
    break unless y == false
    prompt('That is not a valid entry.')
  end

  # request operator
  operator_prompt = <<-MSG
  Which operation would you like to perform?
    + to add
    - to subtract
    x to multiply
    / to divide
  MSG

  operator = ''
  loop do
    prompt(operator_prompt)
    operator = gets.chomp
    break if %w(+ - x /).include?(operator)
    prompt('That is not a valid entry.')
  end

  # perform operation and report result
  result = case operator
           when '+' then x + y
           when '-' then x - y
           when 'x' then x * y
           when '/' then x.to_f / y.to_f
           end

  prompt("The result is #{result}")
  
  prompt("Would you like to performa another calculation? (Enter 'Y' to calculate)")
  continue = gets
  break unless continue.downcase.start_with?('y')
end

prompt('Goodbye')
