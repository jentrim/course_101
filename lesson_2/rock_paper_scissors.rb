def prompt(message)
  puts "=> #{message}"
end

def evaluate_choices(choice1, choice2) 
    choice1 == 'rock' && choice2 == 'scissors' ||
    choice1 == 'paper' && choice2 == 'rock' ||
    choice1 == 'scissors' && choice2 == 'paper'
end

def display_winner(player, computer)
  if evaluate_choices(player, computer)
    prompt('You win!')
  elsif evaluate_choices(computer, player)
    prompt('Computer wins!')
  else
    prompt('Tie!')
  end
end

loop do
  choices = %w(rock paper scissors)
  player_choice = ''
  loop do
    prompt("Please choose rock, paper, or scissors.")
    player_choice = gets.chomp
    break if choices.include?(player_choice)
    prompt("That is not a valid choice.")
  end

  computer_choice = choices.sample
  prompt("Computer chooses #{computer_choice}")

  display_winner(player_choice, computer_choice)
  
  prompt("Would you like to play again? Enter 'Y' to continue.")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Goodbye!')
