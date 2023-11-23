# frozen_string_literal: true

# Handles all characters of the word element
class Word
  attr_reader :selected_word

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
    @masked_word
  end

  def fully_guessed?
    !@masked_word.include?('-')
  end

  def letter_valid?(letter)
    [*('a'..'z')].include?(letter)
  end

  def select_word
    words = File.open('google-10000-english-no-swears.txt', 'r', &:readlines)
    words = words.map(&:chomp)
    words.select { |word| word.length.between?(5, 12) }.sample
  end
end
