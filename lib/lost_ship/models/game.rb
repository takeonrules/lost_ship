require 'dry/struct'
require 'lost_ship/models/types'
require 'lost_ship/models/threat'
require 'lost_ship/models/fleet'
module LostShip
  module Models
    class Game < Dry::Struct
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
