# frozen_string_literal: true

require './lib/player'
require './lib/word'
require './lib/hangman_states'
require './lib/colors'
require 'json'
require 'yaml'

# Handles all game attributes and functions
class Game
  include HangmanStates
  include Colors

  def initialize(player, word)
    @player = player
    @word = word
    @attempts_left = 8
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

      #{HangmanStates::STATES[8 - @attempts_left]}
      #{display_guessed_letters}
      Incorrect guesses left: #{@attempts_left}
      #{@word.display}

    HEREDOC
  end

  def display_guessed_letters
    print 'Letters guessed: '
    @letters_guessed.each do |letter|
      if @word.selected_word.include?(letter)
        print "#{color_letter(letter, 'green')} "
      else
        print "#{color_letter(letter, 'red')} "
      end
    end
    puts
  end

  def process_guess(guess)
    save_game if guess.downcase == 'save'
    return puts "Invalid input: #{guess}" unless @word.letter_valid?(guess)
    return puts "#{guess} has already been guessed" if @letters_guessed.include?(guess)

    @letters_guessed << guess
    update_game_state(guess)
  end

  def update_game_state(guess)
    if @word.selected_word.include?(guess)
      @word.reveal_letter(guess)
      puts color_letter("\nGood guess!", 'yellow')
    else
      @attempts_left -= 1
      puts color_letter("\nNo luck!", 'magenta')
    end
  end

  def save_game
    File.open('./saves/hangman-progress.yaml', 'w') { |f| f.write(YAML.dump(self)) }
    puts 'Game Saved! Thanks for playing'
    exit
  end

  def conclude_game
    if @attempts_left.positive?
      puts "Congrats! You guessed the word: #{@word.selected_word}"
    else
      puts HangmanStates::STATES[8]
      puts "Sorry. You lost! The word was: #{@word.selected_word}"
    end
  end
end
