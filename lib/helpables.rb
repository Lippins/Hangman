# frozen_string_literal: true

# Holds functions that determine game appearance
module Helpables
  HANGMAN_STATES = [
    "
    +---+
        |
        |
        |
        |
        |
    =========
    [*******]
    ",
    "
    +---+
    |   |
        |
        |
        |
        |
    =========
    [H******]
    ",
    "
    +---+
    |   |
    O   |
        |
        |
        |
    =========
    [HA*****]
    ",
    "
    +---+
    |   |
    O   |
    |   |
        |
        |
    =========
    [HAN****]
    ",
    "
    +---+
    |   |
    O   |
    /|  |
        |
        |
    =========
    [HANG***]
    ",
    "
    +---+
    |   |
    O   |
    /|\\ |
        |
        |
    =========
    [HANGM**]
    ",
    "
    +---+
    |   |
    O   |
    /|\\ |
    /   |
        |
    =========
    [HANGMA*]
    ",
    "
    +---+
    |   |
    O   |
    /|\\ |
    / \\ |
        |
    =========
    [HANGMAN]"
  ].freeze

  COLORS = {
    'red' => "\e[31m",
    'green' => "\e[32m",
    'reset' => "\e[0m"
  }.freeze

  def color_letter(letter, color)
    COLORS[color] + letter + COLORS['reset']
  end
end
