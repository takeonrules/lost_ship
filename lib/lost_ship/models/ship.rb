require 'dry/struct'
require 'dry/schema'
require 'lost_ship/models/types'
module LostShip
  module Models
    class Ship < Dry::Struct
      transform_keys(&:to_sym)
      attribute :name, Dry::Types['strict.string']
      attribute :leaps_since_incident, Dry::Types['strict.integer'].default(0)
      attribute :fuel, Dry::Types['strict.integer'].default(6)
      attribute :parts, Dry::Types['strict.integer'].default(6)
      attribute :bscore, Dry::Types['strict.integer'].default(0)
      attribute :new_recruits, Dry::Types['strict.integer'].default(0)
      attribute :halfway_trained_recruits, Dry::Types['strict.integer'].default(0)
      class Hull < Dry::Struct
        transform_keys(&:to_sym)
        attribute :damage, Dry::Types['strict.integer'].default(0)
        attribute :upgraded, Dry::Types['params.bool'].default(false)
        def to_s
          text = "Hull"
          text += "+" if upgraded
          text += ": #{damage} damage"
        end
      end
      attribute :hull, Types.Constructor(Hull).default { Hull.new }

      class Upgradeable < Dry::Struct
        transform_keys(&:to_sym)
        attribute :status, Dry::Types['strict.integer'].default(100)
        attribute :upgraded, Dry::Types['params.bool'].default(false)
        def to_s
          text = "#{name}"
          text += "+" if upgraded
          text += ": "
          if status == 0
            text += "inop"
          else
            text += "#{status}%"
          end
          text
        end
      end
      private_constant :Upgradeable

      class Engines < Upgradeable
        def name; "Engines"; end
      end
      attribute :engines, Types.Constructor(Engines).default { Engines.new }

      class MiningLaser < Upgradeable
        def name; "Minging Laser"; end
      end
      attribute :mining_laser, Types.Constructor(MiningLaser).default { MiningLaser.new }

      class SickBay < Upgradeable
        def name; "Sick Bay"; end
      end
      attribute :sick_bay, Types.Constructor(SickBay).default { SickBay.new }

      class ScoutBay < Upgradeable
        def name; "Scout Bay"; end
      end

      attribute :scout_bay, Types.Constructor(ScoutBay).default { ScoutBay.new }
      class Sensors < Upgradeable
        def name; "Sensors"; end
      end
      attribute   :sensors, Types.Constructor(Sensors).default { Sensors.new }

      COMPONENT_STATUS_RANGE = [0,33,66,100]

      Schema = Dry::Schema.JSON do
        required(:name).filled(:string)
        required(:leaps_since_incident).filled(:integer, gteq?: 0)
        required(:fuel).filled(:integer, gteq?: 0)
        required(:parts).filled(:integer, gteq?: 0)
        required(:bscore).filled(:integer, gteq?: 0)
        required(:hull).hash do
          required(:damage).value(:integer, included_in?: (0..7).to_a)
          required(:upgraded).filled(:bool?)
        end
        required(:new_recruits).filled(:integer, included_in?: (0..6).to_a)
        required(:halfway_trained_recruits).filled(:integer, included_in?: (0..6).to_a)

        required(:engines).hash do
          required(:status).filled(:integer, included_in?: COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:mining_laser).hash do
          required(:status).filled(:integer, included_in?: COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:scout_bay).hash do
          required(:status).filled(:integer, included_in?: COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:sick_bay).hash do
          required(:status).filled(:integer, included_in?: COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:sensors).hash do
          required(:status).filled(:integer, included_in?: COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
      end
    end
  end
end
