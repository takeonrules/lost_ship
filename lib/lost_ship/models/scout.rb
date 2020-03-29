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
      STATUSES = {
        STATUS_DESTROYED => "Dest",
        STATUS_INOPERABLE => "Inop",
        STATUS_FIFTY_PERCENT => "50%",
        STATUS_OPERATIONAL => "100%"
      }
      Schema = Dry::Schema.JSON do
        required(:name).filled(:string, max_size?: 10)
        required(:status).filled(:integer, included_in?: STATUSES.keys)
      end

      def to_s
        "#{name} (#{STATUSES.fetch(status)})"
      end
    end
  end
end
