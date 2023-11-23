# frozen_string_literal: true

# Holds functions that determine game colors
module Colors
  COLORS = {
    'red' => "\e[31m",
    'green' => "\e[32m",
    'reset' => "\e[0m",
    'yellow' => "\e[33m",
    'blue' => "\e[34m",
    'magenta' => "\e[35m",
    'cyan' => "\e[36m"
  }.freeze

  def color_letter(letter, color)
    COLORS[color] + letter + COLORS['reset']
  end
end
