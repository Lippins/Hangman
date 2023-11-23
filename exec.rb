# frozen_string_literal: true

require './lib/game'
require './lib/player'
require './lib/word'

puts <<~HEREDOC

  Welcome to H-A-N-G-M-A-N

  Would you like to: [1] Start a new game
                     [2] Load a saved game
  Enter '1' or '2'
HEREDOC

player = Player.new
word = Word.new

if player.choose_game == '1'
  game = Game.new(player, word)
else
  file_path = './saves/hangman-progress.yaml'
  game = YAML.load_file(file_path, permitted_classes: [Player, Game, Word])
  sleep 2
  puts "\nSaved game loaded..."
end

game.play
