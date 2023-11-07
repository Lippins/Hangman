# frozen_string_literal: true

# Handles player activities
class Player
  def initialize; end

  def choose_letter
    puts "Enter a letter, or type 'save' to save progress:"
    @letter = gets.chomp.downcase
  end
end
