choices = %w(r p s)

def prompt(message)
  puts "=> #{message}"
end

def evaluate_choices(choice1, choice2) 
  choice1 == 'r' && choice2 == 's' ||
    choice1 == 'p' && choice2 == 'r' ||
      choice1 == 's' && choice2 == 'p'
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
  
def update_player_score(player, computer)
  if evaluate_choices(player,computer)
    1
  else
    0
  end
end

def update_computer_score(computer, player)
  if evaluate_choices(computer,player)
    1
  else
    0
  end
end

loop do
  prompt('Welcome to Rock Paper Scissors! The first player to reach five points wins!')
  player_score = 0
  computer_score = 0
  until player_score == 5 || computer_score == 5
    
    player_choice = ''
    loop do
      prompt("Please choose rock (r), paper (p), or scissors (s).")
      player_choice = gets.chomp
      break if choices.include?(player_choice)
      prompt("That is not a valid choice.")
    end

    computer_choice = choices.sample
    prompt("Computer chooses #{computer_choice}")

    display_winner(player_choice, computer_choice)
    
    player_score += update_player_score(player_choice, computer_choice)
    computer_score += update_computer_score(computer_choice, player_choice)
  end
  
  prompt("Your score: #{player_score}     Computer score: #{computer_score}\n")
  puts player_score == 3 ? 'You are the winner!' : 'Computer is the winner!'
  
  prompt("Would you like to play again? Enter 'Y' to continue.")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt('Goodbye!')
