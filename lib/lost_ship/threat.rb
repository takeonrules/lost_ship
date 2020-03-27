require 'lost_ship/types'
module LostShip
  class Threat < Dry::Struct
    attribute :round,LostShip::Types::Integer
    attribute :ships, LostShip::Types::Array
  end
end
