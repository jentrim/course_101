choices = %w(r p s l sp)

def prompt(message)
  puts "=> #{message}"
end

def evaluate_choices(choice1, choice2)
  choice1 == 'r' && (choice2 == 's' || choice2 == 'l') ||
    choice1 == 'p' && (choice2 == 'r' || choice2 == 'sp') ||
    choice1 == 's' && (choice2 == 'p' || choice2 == 'l') ||
    choice1 == 'l' && (choice2 == 'sp' || choice2 == 'p') ||
    choice1 == 'sp' && (choice2 == 's' || choice2 == 'r')
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

def display_computer_choice(choice)
  convert_choice = {
    'r': 'rock',
    'p': 'paper',
    's': 'scissors',
    'l': 'lizard',
    'sp': 'spock'
  }
  prompt("Computer chooses #{convert_choice[choice.to_sym]}.")
end

loop do
  prompt('Welcome to Rock Paper Scissors Lizard Spock')
  player_choice = ''
  loop do
    prompt("Please choose rock (r), paper (p), scissors (s),
                               lizard (l), or spock(sp).")
    player_choice = gets.chomp
    break if choices.include?(player_choice)
    prompt("That is not a valid choice.")
  end

  computer_choice = choices.sample
  display_computer_choice(computer_choice)
  display_winner(player_choice, computer_choice)
  prompt("Would you like to play again? Enter 'Y' to continue.")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Goodbye!')
