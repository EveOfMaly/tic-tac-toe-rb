 # Define your WIN_COMBINATIONS constant
 WIN_COMBINATIONS = [
    [0,1,2],  #top row win 
    [3,4,5],  #middle row win 
    [6,7,8],  #bottom row win 
    [0,3,6],  #left column  win 
    [1,4,7],  #middle column  win 
    [2,5,8],  #right column  win 
    [0,4,8],  #left diangle  win 
    [2,4, 6]  #right diangle  win 
  ]


  #display the board based on board arguments 
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


#converts the input into index on the board 
def input_to_index(input)
    input.to_i - 1
end

#from uses input converts input into a move
 def move(board, index, player)
    board[index] = player
 end

 # confirms if the position is taken
def position_taken?(board, index)
    !(board[index].nil? || board[index] == " " or board[index] =="")
end

# def position_taken?(board,index)
#     if board[index] == "" || board[index] == " " || board[index] == nil
#         false
#     elsif board[index] == "X" || board[index] == "O"
#         true
#     end
# end

#returns true if the move is valid and false or nil if not 
def valid_move?(board,index)
    if index.between?(0,9) == true && position_taken?(board,index) == false 
        true 
    else
        false
    end
end

#takes in argument of board and returns the number of turns that have been played 
def turn_count(board)
    board.count { |token| token == "O" || token == "X"}
end

#takes in the board and if even it is "X" and odd it is "O"
def current_player(board)

    turn_count(board).even? ? "X" : "O"
    # if turn_count(board).even? == true 
    #     return "X"
    # else
    #     return "O"
    # end
end


def turn(board)
    puts "Please enter 1-9:"
    input = gets.chomp 
    index = input_to_index(input)
    if valid_move?(board,index) == true 
        move(board, index, current_player(board))
        display_board(board)
    else
        turn(board)
    end
end
 
  
  #for each win_combation in WIN_COMBINATION 
  #win_combination is a winning combo from WIN_COMBINATION
  #grab each index from win_combination
  def won?(board)
    WIN_COMBINATIONS.each do | win_combination |
      win_index_1 = win_combination [0]
      win_index_2 = win_combination [1]
      win_index_3 = win_combination [2]
  
      position_1 = board[win_index_1] #load the value of the board at win_index_1
      position_2 = board[win_index_2] #load the value of the board at win_index_2
      position_3 = board[win_index_3] #load the value of the board at win_index_3
  
      if position_1 == position_2 &&  position_2 == position_3  && position_taken?(board, win_index_1)
        return win_combination #return the win_combination indexes that won
      end
    end
    return false
  end
  
  
  def full?(board)
    board.all? {|token| token == "X" || token == "O"}
  end
  
  def draw?(board)
    full?(board) && !won?(board)
  end
  
  def over?(board)
    won?(board) || draw?(board) || full?(board)
  end 
  
  def winner(board)
    if won?(board) != false 
       winning_combo = won?(board)
       board[winning_combo.first]
    end
  end
  
  # def draw?(board)
  #   # if won?(board) == false && full?(board) == false
  #   #   false
  #   # elsif won?(board) == true 
  #   #   false 
  #   # elsif won?(board) == false && full?(board) == true 
  #   #     true 
  #   # end
  # end
  
def play(board)
    while !over?(board) && !won?(board) && !draw?(board)
        turn(board)
    end

    if won?(board) 
        puts "Congratulations #{winner(board)}!"
    end

    if draw?(board) 
        puts "Cat's Game!"
    end
end
