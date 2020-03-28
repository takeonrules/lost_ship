require 'dry/struct'
require 'lost_ship/structs/types'
module LostShip
  module Structs
    class Scout < Dry::Struct
      transform_keys(&:to_sym)
      attribute :name, Dry::Types['coercible.string']
      attribute :status, Dry::Types['strict.integer'].default(100)
    end
  end
end
