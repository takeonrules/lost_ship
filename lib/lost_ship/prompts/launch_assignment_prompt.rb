require 'dry/initializer'
require 'readline'

module LostShip
  module Prompts
    # @example
    #
    #           10        20        30        40        50        60        70        80
    #   ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
    #   __Pilots__                              __Scout Ships__
    #   1) Apollo: K0                           a) Red One (100%)
    #   2) Bast: K0                             b) Red Two (100%)
    #   3) Circe: K0                            c) Red Three (100%)
    #   4) Dionysus: K0                         d) Red Four (100%)
    #   5) Enlil: K0                            e) Red Five (100%)
    #   6) Freya: K0                            f) Red Six (100%)
    #
    #   Select pairings: 1a 2b 3c
    class LaunchAssignmentPrompt
      def self.test
        new(filename: "/Users/jfriesen/git/lost_ship/spec/fixtures/base-game.json").run
      end
      def self.run(**kwargs)
        new(**kwargs).run
      end
      extend Dry::Initializer
      option :filename
      option :game, default: -> { LostShip.load_from(filename: filename) }

      def run
        puts "You may launch up to #{launchable_scouts} scouts"
        puts "Assign pilots to their scouts\n\n"
        Views.render(:scouts_and_pilots, game: game)
        puts ""
        prompt = true
        while prompt
          input = ::Readline.readline(%(Select pairings (e.g. "1a b3"): ), true)
          pairings = response
          if pairings.size > launchable_scouts
            puts "\tRetry. You may launch up #{launchable_scouts} scouts"
          end
        end
      end

      private

      def launchable_scouts
        3
      end
    end
  end
end
