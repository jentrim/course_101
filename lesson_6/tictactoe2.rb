require 'pry'
PLAYERS = []

WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
           [1, 4, 7], [2, 5, 8], [3, 6, 9],
           [1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "=> #{message}"
end

def greeting
  prompt('Welcome to Tic Tac Toe')
  prompt('You are X')
end

def choose_who_moves_first
  prompt("Do you want to move first? (Enter 'Y' or 'N')")
  answer = gets.chomp.downcase
  if answer.start_with?('y')
    PLAYERS[0], PLAYERS[1] = 'human', 'computer'
  else
    PLAYERS[0], PLAYERS[1] = 'computer', 'human'
  end
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
      return "You win!"
    elsif row.all? { |entry| brd[entry] == "O" }
      return "The computer wins!"
    elsif board_full?(brd)
      return "Tie game!"
    end
  end
  false
end

def play_again?
  prompt('Would you like to play again? (Enter Y or N)')
  gets.chomp.downcase
end

greeting

loop do
  PLAYERS = choose_who_moves_first
  board = initialize_board
  
  until !!winner?(board)
    PLAYERS.each do |player|
      display_board(board)
      choose_move!(board, player)
      break if winner?(board)
    end
  end
  
  display_board(board)
  prompt(winner?(board))
  continue = play_again?
  break if continue.start_with?('n')
end

prompt('Goodbye!')
