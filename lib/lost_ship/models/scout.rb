require 'dry/struct'
require 'dry/schema'
require 'lost_ship/models/types'
module LostShip
  module Models
    class Scout < Dry::Struct
      transform_keys(&:to_sym)
      attribute :name, Dry::Types['coercible.string']
      attribute :status, Dry::Types['strict.integer'].default(100)

      STATUS_DESTROYED = 0
      STATUS_INOPERABLE = 33
      STATUS_FIFTY_PERCENT = 66
      STATUS_OPERATIONAL = 100
      STATUS_RANGE = [
        STATUS_DESTROYED,
        STATUS_INOPERABLE,
        STATUS_FIFTY_PERCENT,
        STATUS_OPERATIONAL
      ]
      Schema = Dry::Schema.JSON do
        required(:name).filled(:string, max_size?: 10)
        required(:status).filled(:integer, included_in?: STATUS_RANGE)
      end
    end
  end
end
