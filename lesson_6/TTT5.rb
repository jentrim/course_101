require 'pry'

WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
           [1, 4, 7], [2, 5, 8], [3, 6, 9],
           [1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "=> #{message}"
end

def greeting
  system 'clear'
  prompt('Welcome to Tic Tac Toe')
  prompt('You are X')
end

def choose_who_moves_first
  answer = ''
  loop do
    prompt("Do you want to move first? (Enter 'Y' or 'N')")
    answer = gets.chomp.downcase
    break if answer.start_with?('y', 'n')
    prompt('Please enter Y or N')
  end
  answer.start_with?('y') ? 'human' : 'computer'
end

def alternate_first_move(player)
  player.start_with?('h') ? 'computer' : 'human'
end

def alternate_player(player)
  player.start_with?('h') ? 'computer' : 'human'
end

def display_board(brd)
  system 'clear'
  puts ""
  puts "     |     |     "
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}  "
  puts "     |     |     "
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = num }
  new_board
end

def initialize_scores
  File.open('ttt_scores.txt', 'w'){|f| 2.times{f.puts(0)} }
end

def available_moves(brd)
  brd.keys.select { |k| k == brd[k] }
end

def player_move!(brd)
  square = ''
  loop do
    prompt('Please choose a square')
    square = gets.chomp.to_i
    break if available_moves(brd).include?(square)
    prompt('That square is not available')
  end
  brd[square] = 'X'
end

def winning_move(brd)
  WINNERS.each do |row|
    if row.select{|entry| brd[entry] == 'O'}.count == 2
      winning_move = row.select{|entry| brd[entry] == entry}
      return winning_move[0] if available_moves(brd).include?(winning_move[0])
    end
  end
  nil
end

def block_win(brd)
  WINNERS.each do |row|
    if row.select{|entry| brd[entry] == 'X'}.count == 2
      block = row.select{|entry| brd[entry] == entry}
      return block[0] if available_moves(brd).include?(block[0])
    end
  end
  nil
end
  
def computer_move!(brd)
  move = nil
  if !! winning_move(brd)
    move = winning_move(brd)
  elsif !!block_win(brd)
    move = block_win(brd)
  else
    move = available_moves(brd).sample
  end
  brd[move] = 'O'
end

def choose_move!(brd, player)
  case player
  when 'human' then player_move!(brd)
  when 'computer' then computer_move!(brd)
  end
end

def board_full?(brd)
  available_moves(brd).empty?
end

def winner?(brd)
  WINNERS.each do |row|
    if row.all? { |entry| brd[entry] == "X" }
      return 'human'
    elsif row.all? { |entry| brd[entry] == "O" }
      return 'computer'
    end
  end
  false
end

def import_scores
  scores_in = []
  File.readlines('ttt_scores.txt').each{|line| scores_in.push(line.chomp.to_i)}
  scores_in
end

def update_scores(brd)
  scores = import_scores
  if winner?(brd) == 'human'
    scores[0] += 1
  elsif winner?(brd) == 'computer'
    scores[1] += 1
  end
  export_scores(scores)
  scores
end

def export_scores(scores_out)
  File.open('ttt_scores.txt', 'w') do |f| 
    scores_out.each{|num| f.puts(num)}
  end
end

def display_updated_scores(brd)
  updated_scores = update_scores(brd)
  prompt('CURRENT SCORE:')
  prompt("Human: #{updated_scores[0]}   Computer: #{updated_scores[1]}")
end

def report_winner(brd)
  if winner?(brd) == 'human'
    return "You win!"
  elsif winner?(brd) == 'computer'
    return "The computer wins!"
  elsif board_full?(brd)
    return "Tie game!"
  end
end

def play_again?
  answer = ''
  loop do 
    prompt('Would you like to play again? (Enter Y or N)')
    answer = gets.chomp.downcase
    break if answer.start_with?('y', 'n') 
    prompt('Please enter Y or N')
  end
  answer
end

greeting
initialize_scores
first_move = choose_who_moves_first

loop do
  current_player = first_move
  board = initialize_board
  
  loop do
    display_board(board)
    choose_move!(board, current_player)
    current_player = alternate_player(current_player)
    break if !!winner?(board) || board_full?(board)
  end
  
  display_board(board)
  prompt(report_winner(board))
  display_updated_scores(board)
  continue = play_again?
  break if continue.start_with?('n')
  first_move = alternate_first_move(current_player)
end

prompt('Goodbye!')
