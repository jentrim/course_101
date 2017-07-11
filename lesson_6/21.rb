CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

VALUES = { '2':  2, '3':  3, '4':  4, '5':  5, '6':  6, 
          '7':  7, '8':  8, '9':  9, '10':  10, 'Jack':  10, 
          'Queen':  10, 'King': 10}
          
def prompt(string)
  puts "=> #{string}"
end

def greeting
  prompt('WELCOME TO 21')
  prompt('')
  prompt('')
end

def initialize_deck
  deck = []
  4.times{CARDS.each{|card| deck.push(card)}}
  deck.shuffle
end

def deal_hand(deck)
  cards = []
  2.times{cards.push(deck.shift)}
  cards
end

def display_player_hand(hand)
  if hand.length > 2
    display_hand = hand.dup
    display_hand[-1] = 'and ' + hand[-1].to_s
    display_hand.join(', ')
  else
    hand.join(' and ')
  end
end

def display_computer_hand(hand)
  "#{hand.slice(1, hand.length - 1).join(', ')} and unknown card"
end 
  
def display_hands(computer_hand, human_hand)
  system 'clear'
  prompt("Dealer has:  #{display_computer_hand(computer_hand)}")
  prompt("You have:  #{display_player_hand(human_hand)}")
end

def hit_or_stay?
  prompt('')
  answer = ''
  loop do 
    prompt('Would you like to hit or stay?  Enter H or S')
    answer = gets.chomp.downcase
    break if answer.start_with?('h', 's')
    prompt('That is not a valid answer.')
  end
  answer
end
  
def hit_me!(hand, deck)
  hand.push(deck.shift)
  hand
end

def add_aces(sum, aces_count)
  case aces_count
  when 1
    sum + 11 <= 21 ? sum + 11 : sum + 1
  when 2
    sum + 12 <= 21 ? sum + 12 : sum + 2
  when 3
    sum + 13 <= 21 ? sum + 13 : sum + 3
  when 4
    sum + 14 <= 21 ? sum + 14 : sum + 4
  end
end  

def evaluate_hand(hand)
  aces = hand.select{|card| card == 'Ace'}.count
  other_cards = hand.select{|card| card != 'Ace'}
  non_ace_sum = other_cards.map{|card| VALUES[card.to_s.to_sym]}.reduce(:+)
  if aces > 0
    add_aces(non_ace_sum, aces)
  else
    non_ace_sum
  end
end

def busted?(score)
  score > 21
end

def hit_dealer?(score)
  score < 17
end

def determine_winner(dealer_total, player_total)
  player_total > dealer_total ? "You win!" : "Dealer wins!"
end

def display_final_hands(computer_hand, human_hand)
  system 'clear'
  prompt('FINAL HANDS')
  prompt("Dealer has:  #{display_player_hand(computer_hand)}")
  prompt("You have:  #{display_player_hand(human_hand)}")
  prompt('')
end

def display_winner(dealer_total, player_total)
  prompt('FINAL SCORE')
  prompt("Dealer has:  #{dealer_total}")
  prompt("You have:  #{player_total}")
  prompt('')
  prompt(determine_winner(dealer_total, player_total))
end

def play_again
  play = ''
  loop do 
    prompt('Would you like to play again?  Enter Y or N')
    play = gets.chomp.downcase
    break if play.start_with?('y', 'n')
    prompt('That is not a valid answer')
  end
  play
end
  
loop do
  greeting  
  game_deck = initialize_deck
  dealer_hand = deal_hand(game_deck)
  player_hand = deal_hand(game_deck)
  dealer_score = evaluate_hand(dealer_hand)
  player_score = evaluate_hand(player_hand)
  display_hands(dealer_hand, player_hand)

  loop do
    hit = hit_or_stay?
    break if hit.start_with?('s')
    player_hand = hit_me!(player_hand, game_deck)
    player_score = evaluate_hand(player_hand)
    display_hands(dealer_hand, player_hand)
    break if busted?(player_score)
  end

  if busted?(player_score)
    prompt("You busted!  Dealer wins!")
  else
    loop do
      break unless hit_dealer?(dealer_score)
      hit_me!(dealer_hand, game_deck)
      dealer_score = evaluate_hand(dealer_hand)
      display_hands(dealer_hand, player_hand)
      break if busted?(dealer_score)
    end

    if busted?(dealer_score)
      prompt('Dealer busted!  You win!')
    else
      display_final_hands(dealer_hand, player_hand)
      display_winner(dealer_score, player_score)
    end
  end
  break if play_again.start_with?('n')
end

prompt('Goodbye!')
