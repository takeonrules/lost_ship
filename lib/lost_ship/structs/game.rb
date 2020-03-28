require 'dry/struct'
require 'lost_ship/structs/types'
require 'lost_ship/structs/threat'
require 'lost_ship/structs/fleet'
module LostShip
  module Structs
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
