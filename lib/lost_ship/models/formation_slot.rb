require 'dry/struct'
require 'dry/schema'
require 'lost_ship/models/types'
module LostShip
  module Models
    class FormationSlot < Dry::Struct
      transform_keys(&:to_sym)
      attribute :pilot_index, Dry::Types['strict.integer']
      attribute :scout_index, Dry::Types['strict.integer']

      Schema = Dry::Schema.JSON do
        required(:pilot_index).filled(:integer, gt?: 0)
        required(:scout_index).filled(:integer, gt?: 0)
      end
    end
  end
end
