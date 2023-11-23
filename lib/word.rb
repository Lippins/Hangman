# frozen_string_literal: true

require './lib/colors'

# Handles all characters of the word element
class Word
  include Colors
  attr_reader :selected_word, :masked_word

  def initialize
    @selected_word = select_word.upcase
    @masked_word = '_' * @selected_word.length
  end

  def reveal_letter(letter)
    @selected_word.length.times do |i|
      @masked_word[i] = letter if @selected_word[i] == letter
    end
  end

  def display
    color_letter(@masked_word, 'blue')
  end

  def fully_guessed?
    !@masked_word.include?('_')
  end

  def letter_valid?(letter)
    [*('a'..'z')].include?(letter.downcase) || letter.downcase == 'save'
  end

  def select_word
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words = words.map(&:chomp)
    words.select { |word| word.length.between?(5, 12) }.sample
  end
end
