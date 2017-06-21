def prompt(message)
  puts "=> #{message}"
end

def verify_input
  Float(gets) rescue false
end

puts 'Welcome to the loan payment calculator.'

loan_amount = nil
loop do
  prompt('Please enter the loan amount')
  loan_amount = verify_input
  break unless loan_amount == false || loan_amount <= 0
  prompt('That is an invalid entry.')
end

apr = nil
loop do
  prompt('Please enter the annual percentage rate (APR).')
  apr = verify_input
  break unless apr == false || apr <= 0
  prompt('That is an invalid entry.')
end

duration = nil
loop do
  prompt('Please enter the loan duration in months.')
  duration = Integer(gets) rescue false
  break unless duration == false || duration <= 0
  prompt('That is an invalid entry.')
end

monthly_percentage_rate_as_decimal = (apr / 12) / 100
loan_amount_in_cents = loan_amount * 100

monthly_payment_in_cents = loan_amount_in_cents * 
                           (monthly_percentage_rate_as_decimal / 
                           (1 - (1 + monthly_percentage_rate_as_decimal)**(-duration)))

monthly_payment = (monthly_payment_in_cents / 100).round(2)

result = <<-MSG
Monthly payment: $#{format('%02.2f', monthly_payment)}
Loan amount:     $#{format('%02.2f', loan_amount)}
APR:             #{apr}%
Loan duration:   #{duration} months
MSG

prompt(result)
