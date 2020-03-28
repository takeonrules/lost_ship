require 'dry/struct'
require 'lost_ship/structs/types'
module LostShip
  module Structs
    class FormationSlot < Dry::Struct
      transform_keys(&:to_sym)
      attribute :pilot_index, Dry::Types['strict.integer']
      attribute :scout_index, Dry::Types['strict.integer']
    end
  end
end
