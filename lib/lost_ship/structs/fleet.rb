require 'dry/struct'
require 'lost_ship/structs/types'
require 'lost_ship/structs/formation_slot'
require 'lost_ship/structs/ship'
require 'lost_ship/structs/scout'
require 'lost_ship/structs/pilot'
module LostShip
  module Structs
    class Fleet < Dry::Struct
      transform_keys(&:to_sym)
      attribute? :formation, Dry::Types['coercible.array'].of(FormationSlot)
      attribute :ship, Types.Constructor(Ship)
      attribute :scouts, Dry::Types['coercible.array'].of(Scout)
      attribute :pilots, Dry::Types['coercible.array'].of(Pilot)

      Schema = Dry::Schema.JSON do
        optional(:formation).array(FormationSlot::Schema)
        required(:ship).hash(Ship::Schema)
        required(:scouts).array(Scout::Schema)
        required(:pilots).array(Pilot::Schema)
      end
    end
  end
end
