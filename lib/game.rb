# frozen_string_literal: true

require './lib/player'
require './lib/word'
require './lib/helpables'
require 'json'

# Handles all game attributes and functions
class Game
  include Helpables

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

      #{Helpables::HANGMAN_STATES[9 - @attempts_left]}
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

  def save_game
    data = {
      word: @word.selected_word,
      masked_word: @word.masked_word,
      attempts_left: @attempts_left,
      letters_guessed: @letters_guessed
    }

    File.open('./saves/hangman-progress.json', 'w') { |f| f.write(data.to_json) }
  end

  def conclude_game
    if @attempts_left.positive?
      puts "Congrats! You guessed the word: #{@word.selected_word}"
    else
      puts Helpables::HANGMAN_STATES[7]
      puts "Sorry. You lost! The word was: #{@word.selected_word}"
    end
  end
end

Game.new(Player.new, Word.new).save_game
