# frozen_string_literal: true

# Handles player activities
class Player
  def initialize; end

  def choose_letter
    puts "Enter a letter, or type 'save' to save progress:"
    @letter = gets.chomp.upcase
  end

  def choose_game
    @choice = gets.chomp
    return @choice if %w[1 2].include?(@choice)

    puts "Invalid input. Please enter '1' or '2'"
    choose_game
  end
end
