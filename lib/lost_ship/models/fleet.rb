require 'dry/struct'
require 'lost_ship/models/types'
require 'lost_ship/models/formation_slot'
require 'lost_ship/models/ship'
require 'lost_ship/models/scout'
require 'lost_ship/models/pilot'
module LostShip
  module Models
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
