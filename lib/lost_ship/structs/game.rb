require 'dry/struct'
require 'lost_ship/structs/types'
require 'lost_ship/structs/threat'
module LostShip
  module Structs
    class Game < Dry::Struct
      attribute? :threat, Types.Constructor(Threat)
    end
  end
end
