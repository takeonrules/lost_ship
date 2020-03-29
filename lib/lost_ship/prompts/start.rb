require 'dry-initializer'
require 'readline'

module LostShip
  module Prompts
    class Start
      def self.run(**kwargs)
        new(**kwargs).run
      end
      extend Dry::Initializer
      option :filename

      def run
        puts "Starting a game of Lost Ship"
        ship_name = ::Readline.readline("Name your Colony ship: ", true)
        puts ""
        puts "Next name your six (6) scout ships:"
        scout_names = (1..6).map do |i|
          ::Readline.readline("\tScout ship #{i}: ", true)
        end
        puts ""
        puts "Next name your six (6) starting pilots:"
        pilot_names = (1..6).map do |i|
          ::Readline.readline("\tPilot #{i}: ", true)
        end
        puts ""
        puts "#{ship_name} (Empathy-class Colony Ship)"
        puts "Scout Ships: #{scout_names.join(', ')}"
        puts "Pilots: #{pilot_names.join(', ')}"

        LostShip.start(
          ship_name: ship_name,
          pilot_names: pilot_names,
          scout_names: scout_names,
          filename: filename
        )
      end
    end
  end
end
