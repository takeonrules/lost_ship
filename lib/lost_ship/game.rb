require 'dry/struct'
require 'lost_ship/types'
require 'lost_ship/threat'
module LostShip
  class Game < Dry::Struct
    attribute? :threat, Types.Constructor(Threat)
  end
end
