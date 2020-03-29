require 'dry-initializer'
require 'readline'

module LostShip
  module Prompts
    # @example
    #
    #           10        20        30        40        50        60        70        80
    #   ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    #   __Scout Ships__ (10 char)               __Pilots__ (10 char)
    #   a) Red One: 100%                        1) Athena: 2 kills
    #   b) Red Two: 50%                         2) Freya: 18 kills, injured 2 leaps
    #   c) Red Three: inop                      3) Artemis: 0 kills
    #   d) Red Four: 100%                       4) Hera: 4 kills
    #   e) Red Five: inop                       5) Xena: 1 kill, injured 1 leap
    #   f) Red Five: 100%
    class LaunchAssignmentPrompt
      def self.run(**kwargs)
        new(**kwargs).run
      end
      extend Dry::Initializer
      option :filename
      option :game, default: -> { LostShip.load_from(filename: filename) }

      def run
        puts "Assign pilots to their scouts\n\n"
        Views.render(:scouts_and_pilots, game: game)
        puts ""
      end
    end
  end
end
