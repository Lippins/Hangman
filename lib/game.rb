# frozen_string_literal: true

# Handles all game attributes and functions
class Game
  def initialize
    @words = load_words
    @selected_word = select_word(@words)
  end

  def draw_board
    puts ' _' * @selected_word.length
    puts @selected_word
  end

  def select_word(words)
    words.select { |word| word.length.between?(5, 12) }.sample
  end

  def load_words
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words.map(&:chomp)
  end
end

Game.new.draw_board
