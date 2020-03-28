require 'dry/struct'
module LostShip
  module Structs
    class Threat < Dry::Struct
      transform_keys(&:to_sym)
      attribute :round, Dry::Types['strict.integer']
      attribute :ships, Dry::Types['coercible.array'].constructor(-> (ships) {
        ships.map do |ship|
          type = ship.fetch(:type)
          SHIP_TYPE_LOOKUP.fetch(type).new(**ship)
        end
      })

      class Ship < Dry::Struct
        transform_keys(&:to_sym)
        attribute :damage, Dry::Types['strict.integer']
        attribute :type, Dry::Types['strict.integer']
      end
      private_constant :Ship

      class Mk1 < Ship
        def hit_points; 2; end
        def attacks; 1; end
        def shutdown_after_round; 3; end
      end
      class Mk2 < Ship
        def hit_points; 5; end
        def attacks; 2; end
        def shutdown_after_round; 4; end
      end
      class Mk3 < Ship
        def hit_points; 8; end
        def attacks; 4; end
        def shutdown_after_round; 5; end
      end
      SHIP_TYPE_LOOKUP = {
        1 => Mk1,
        2 => Mk2,
        3 => Mk3
      }
    end
  end
end
