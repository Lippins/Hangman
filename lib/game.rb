# frozen_string_literal: true

require './lib/player'
require './lib/word'

# Handles all game attributes and functions
class Game
  def initialize(player, word)
    @player = player
    @word = word
    @attempts_left = 2
    @letters_guessed = []
  end

  def play
    until game_over?
      display_status
      guess = @player.choose_letter
      process_guess(guess)
    end

    conclude_game
  end

  def game_over?
    @attempts_left.zero? || @word.fully_guessed?
  end

  def display_status
    puts <<~HEREDOC

      Letters guessed: #{@letters_guessed.join(' ')}
      Incorrect guesses left: #{@attempts_left}
      #{@word.display}

    HEREDOC
  end

  def process_guess(guess)
    return puts "Invalid input: #{guess}" unless @word.letter_valid?(guess)
    return puts "#{guess} has already been guessed" if @letters_guessed.include?(guess)

    @letters_guessed << guess

    if @word.selected_word.include?(guess)
      @word.reveal_letter(guess)
      puts 'Correct!'
    else
      @attempts_left -= 1
      puts "Wrong! Attempts left: #{@attempts_left}"
    end
  end

  def conclude_game
    if @attempts_left.positive?
      puts "Congrats! You guessed the word: #{@word.selected_word}"
    else
      puts "Sorry. You lost! The word was: #{@word.selected_word}"
    end
  end
end
