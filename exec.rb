# frozen_string_literal: true

require './lib/game'
require './lib/player'
require './lib/word'

puts <<~HEREDOC

  Welcome to H-A-N-G-M-A-N

  Would you like to: [1] Start a new game
                     [2] Load a game
  Enter '1' or '2'

HEREDOC

player = Player.new
word = Word.new
game = Game.new(player, word)
game.play
