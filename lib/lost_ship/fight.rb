module LostShip
  class Fight
    class Launch
    end

    def initialize(turn:, fleet:)
    end

    INDEX_TO_LETTER = {
      0 => "a", 1 => "b", 2 => "c", 3 => "d", 4 => "e", 5 => "f"
    }
    def scramble
      $stdout.puts "You can launch #{fleet.max_launch} scouts"
      $stdout.puts ""
      $stdout.puts "Pilots"
      fleet.active_pilots.each_with_index do |pilot, index|
        "\t#{INDEX_TO_LETTER.fetch(index)}: #{pilot}"
      end
      $stdout.puts ""
      $stdout.puts "Scouts"
      fleet.operable_scouts.each_with_index do |scout, index|
        "\t#{index}: #{scout}"
      end
    end
  end
end

# You can launch 3 scouts.
#
# Pair Pilots
#   a: Athena (12 kills, injured, ace)
#   b: Henry (1 kill)
#   c: George
#   d: Wallace
#
# And Scouts
#   1: Red One
#   2: Red Two
#   3: Red Three
#
# Enter your pairings:
# => a1 b2 c3
