# frozen_string_literal: true

require './lib/player'

# Handles all game attributes and functions
class Game
  def initialize
    @selected_word = select_word
    @letters_guessed = []
    @board = '_' * @selected_word.length
    @player = Player.new
    display_intro
    # puts @board
    # puts @selected_word
    puts @selected_word
  end

  # working here
  def play_game
    guesses_left = 10
    guesses_left.times do |i|
      if playround
    end
  end

  def play_round
    choice = validate_player_choice(@player.choose_letter)
    if @selected_word.include?(choice)
      puts 'Nice Guess!'
      update_board(choice)
    else
      puts 'Not Quite'
    end
  end

  def display_intro
    puts <<~HEREDOC

      H-A-N-G-M-A-N
      Would you like to: [1] Start a new game
                         [2] Load a game
      Enter '1' or '2'

    HEREDOC
  end

  def display_status(counter)
    puts <<~HEREDOC

      Letters guessed: #{@letters_guessed.join(' ')}
      Incorrect guesses left: #{counter}
      #{@board}

    HEREDOC
  end

  def update_board(letter)
    @selected_word.length.times do |i|
      @board[i] = letter if @selected_word[i] == letter
    end
    true
  end

  def validate_player_choice(letter)
    if !letter_valid?(letter)
      puts "Invalid input: #{letter}"
    elsif letter_taken?(letter)
      puts "You've already guessed the letter '#{letter}'"
    else
      @letters_guessed << letter
      return letter
    end
    validate_player_choice(@player.choose_letter)
  end

  def letter_valid?(letter)
    [*('a'..'z')].include?(letter)
  end

  def letter_taken?(letter)
    @letters_guessed.include?(letter)
  end

  def winner?
    @selected_word == @board
  end

  def select_word
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words = words.map(&:chomp)
    words.select { |word| word.length.between?(5, 12) }.sample
  end
end

test = Game.new
10.times { |_i| play_round }
