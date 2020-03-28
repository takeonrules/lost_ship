require 'dry/struct'
require 'lost_ship/structs/types'
module LostShip
  module Structs
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
    end
  end
end
