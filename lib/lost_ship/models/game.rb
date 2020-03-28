require 'dry/struct'
require 'lost_ship/models/types'
require 'lost_ship/models/threat'
require 'lost_ship/models/fleet'
module LostShip
  module Models
    class Game < Dry::Struct
      def self.start(ship_name:, scout_names:, pilot_names:)
        new(
          fleet: {
            ship: { name: ship_name },
            scouts: Array(scout_names).map { |name| { name: name } },
            pilots: Array(pilot_names).map { |name| { name: name } }
          }
        )
      end
      transform_keys(&:to_sym)
      attribute? :threat, Types.Constructor(Threat)
      attribute :fleet, Types.Constructor(Fleet)

      Schema = Dry::Schema.JSON do
        optional(:threat).hash(Threat::Schema)
        required(:fleet).hash(Fleet::Schema)
      end
    end
  end
end
