require 'dry/struct'
require 'dry/schema'
require 'lost_ship/models/types'
module LostShip
  module Models
    class Pilot < Dry::Struct
      transform_keys(&:to_sym)
      attribute :name, Dry::Types['coercible.string']
      attribute :kills, Dry::Types['strict.integer'].default(0)
      attribute :status, Dry::Types['strict.integer'].default(100)
      attribute? :leaps_injured, Dry::Types['strict.integer'].default(0)

      STATUS_HEALTHY = 100
      STATUS_INJURED = 66
      STATUS_KILL_IN_ACTION = 0
      STATUS_RANGE = [
        STATUS_HEALTHY,
        STATUS_INJURED,
        STATUS_KILL_IN_ACTION
      ]
      Schema = Dry::Schema.JSON do
        required(:name).filled(:string, max_size?: 10)
        required(:kills).filled(:integer, gteq?: 0)
        required(:status).filled(:integer, included_in?: STATUS_RANGE)
        optional(:leaps_injured).filled(:integer, gteq?: 0)
      end

      def to_s
        attributes = []
        if kills >= 6
          attributes << "Ace"
        elsif kills >= 3
          attributes << "Vet"
        end
        attributes << "K#{kills}"
        if leaps_injured > 0
          attributes << "I#{leaps_injured}"
        end
        if attributes.empty?
          return name.to_s
        else
          return "#{name}: #{attributes.join(', ')}"
        end
      end
    end
  end
end
