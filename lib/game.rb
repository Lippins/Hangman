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
    # puts @board
    # puts @selected_word
  end

  def play_round; end

  def update_board(letter)
    @selected_word.length.times do |i|
      @board[i] = letter if @selected_word[i] == letter
    end
    puts @board
  end

  def validate_letter(letter)
    if !letter_valid?(letter)
      puts "Invalid input: #{letter}"
    elsif letter_taken?(letter)
      puts "You've already guessed the letter '#{letter}'"
    else
      return letter
    end
    validate_letter(@player.choose_letter)
  end

  def letter_valid?(letter)
    [*('a'..'z')].include?(letter)
  end

  def letter_taken?(letter)
    @letters_guessed.include?(letter)
  end

  def letter_exists?(letter)
    @selected_word.include?(letter)
  end

  def select_word(words)
    words.select { |word| word.length.between?(5, 12) }.sample
  end

  def load_words
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words.map(&:chomp)
  end
end

# test = Game.new
# test.validate_letter

# Player.new.choose_letter
