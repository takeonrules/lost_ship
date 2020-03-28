require 'dry/struct'
require 'lost_ship/structs/types'
module LostShip
  module Structs
    class Pilot < Dry::Struct
      transform_keys(&:to_sym)
      attribute :name, Dry::Types['coercible.string']
      attribute :kills, Dry::Types['strict.integer'].default(0)
      attribute :status, Dry::Types['strict.integer'].default(100)
      attribute? :leaps_injured, Dry::Types['strict.integer'].default(0)
    end
  end
end
