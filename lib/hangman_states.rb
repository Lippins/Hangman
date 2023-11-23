# frozen_string_literal: true

# Holds string representation of each hangman state
module HangmanStates
  STATES = [
    "
    +---+
        |
        |
        |
        |
        |
    =========
    ",
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
end
