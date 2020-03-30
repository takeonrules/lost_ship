require 'dry/initializer'
require 'dry/monads'
module LostShip
  module Actions
    class CreateLaunch
      extend Dry::Initializer
      include Dry::Monads[:result, :validated, :do]
      option :game

      def call(input:)
        launch = yield validate_input(input: input)
        Success(launch)
      end

      private

      def validate_input(input:)
        elements = input.split(%r{\W})
        # Numbers then letters
        pairings = elements.map { |e| e.split('').sort }
        if pairings.map(&:size).uniq != [2]
          return Failure(:improperly_formed_pairings)
        end
        if pairings.map(&:first).uniq.size != pairings.size
          return Failure(:duplicate_entry)
        end
        # Convert letters to index
        # Convert numbers to index (decrementing)
        # Verify that an active ship exists at each index
        Valid(input)
      end
    end
  end
end
