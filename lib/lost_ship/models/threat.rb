require 'dry/struct'
require 'dry/schema'
module LostShip
  module Models
    class Threat < Dry::Struct
      transform_keys(&:to_sym)
      attribute :round, Dry::Types['strict.integer']
      attribute :ships, Dry::Types['coercible.array'].constructor(-> (ships) {
        ships.map do |ship|
          type = ship.fetch(:type)
          ENEMY_SHIP_TYPE_LOOKUP.fetch(type).new(**ship)
        end
      })

      Schema = Dry::Schema.JSON do
        required(:round).filled(:integer, included_in?: (0..5).to_a)
        required(:ships).array(:hash) do
          required(:type).filled(:integer, included_in?: (1..3).to_a)
          required(:damage).filled(:integer, included_in?: (0..8).to_a)
        end
      end

      class EnemyShip < Dry::Struct
        transform_keys(&:to_sym)
        attribute :damage, Dry::Types['strict.integer']
        attribute :type, Dry::Types['strict.integer']
      end
      private_constant :EnemyShip

      class Mk1 < EnemyShip
        def hit_points; 2; end
        def attacks; 1; end
        def shutdown_after_round; 3; end
      end
      class Mk2 < EnemyShip
        def hit_points; 5; end
        def attacks; 2; end
        def shutdown_after_round; 4; end
      end
      class Mk3 < EnemyShip
        def hit_points; 8; end
        def attacks; 4; end
        def shutdown_after_round; 5; end
      end
      ENEMY_SHIP_TYPE_LOOKUP = {
        1 => Mk1,
        2 => Mk2,
        3 => Mk3
      }
    end
  end
end
