# frozen_string_literal: true

require './lib/player'

# Handles all game attributes and functions
class Game
  def initialize
    @words = load_words
    @selected_word = select_word(@words)
    @letters_guessed = []
    @board = '_' * @selected_word.length
    @player = Player.new
    display_intro
    # puts @board
    # puts @selected_word
  end

  def play_round
    10.downto(1) do |i|
      display_status(i)
      letter = validate_player_choice(@player.choose_letter)
      update_board(letter)
      return puts @board if board_full?
    end
    puts "You lost! You couldn't guess the word: #{@selected_word}"
  end

  def display_intro
    puts <<~HEREDOC
      H-A-N-G-M-A-N
      Would you like to: [1] Start a new game
                         [2] Load a game
      Enter '1' or '2'"
    HEREDOC
  end

  def display_status(counter)
    puts "Letters guessed: #{@letters_guessed.join(' ')}"
    puts "Incorrect guesses left: #{counter}"
    puts @board
    puts
  end

  def update_board(letter)
    if @selected_word.include?(letter)
      puts 'Good guess!'
      @selected_word.length.times do |i|
        @board[i] = letter if @selected_word[i] == letter
      end
    else
      puts 'Not quite!'
    end
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

  def board_full?
    @selected_word == @board
  end

  def select_word(words)
    words.select { |word| word.length.between?(5, 12) }.sample
  end

  def load_words
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words.map(&:chomp)
  end
end

Game.new.play_round
