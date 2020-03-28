require 'dry/struct'
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
      end
      attribute :hull, Types.Constructor(Hull)
      class Upgradeable < Dry::Struct
        transform_keys(&:to_sym)
        attribute :status, Dry::Types['strict.integer'].default(100)
        attribute :upgraded, Dry::Types['params.bool'].default(false)
      end
      class Engines < Upgradeable; end
      attribute :engines, Types.Constructor(Engines)
      class MiningLaser < Upgradeable; end
      attribute :mining_laser, Types.Constructor(MiningLaser)
      class SickBay < Upgradeable; end
      attribute :sick_bay, Types.Constructor(SickBay)
      class ScoutBay < Upgradeable; end
      attribute :scout_bay, Types.Constructor(ScoutBay)
      class Sensors < Upgradeable;end
      attribute :sensors, Types.Constructor(Sensors)

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
