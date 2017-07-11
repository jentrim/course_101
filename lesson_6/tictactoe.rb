require 'pry'

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
  board = initialize_board
  
  loop do
    display_board(board)
    player_move!(board)
    break if winner?(board)
    display_board(board)
    computer_move!(board)
    break if winner?(board)
  end
  
  display_board(board)
  prompt(winner?(board))
  continue = play_again?
  break if continue.start_with?('n')
end

prompt('Goodbye!')
