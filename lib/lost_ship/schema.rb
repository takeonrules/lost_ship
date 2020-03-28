require 'dry/schema'
module LostShip
  # Responsible for tracking the game state
  #
  # There is no conceptual model of the state machine for how the turns
  # progress. Without that model, this is an incomplete schema.
  Schema = Dry::Schema.JSON do
    optional(:threat).hash do
      required(:round).filled(:integer, included_in?: (0..5).to_a)
      required(:ships).array(:hash) do
        required(:type).filled(:integer, included_in?: (1..3).to_a)
        required(:damage).filled(:integer, included_in?: (0..8).to_a)
      end
    end
    required(:fleet).hash do
      optional(:formation).array(:hash) do
        required(:pilot_index).filled(:integer, gteq?: 0)
        required(:scout_index).filled(:integer, gteq?: 0)
      end
      required(:ship).hash do
        required(:name).filled(:string)
        required(:leaps_since_incident).filled(:integer, gteq?: 0)
        required(:fuel).filled(:integer, gteq?: 0)
        required(:parts).filled(:integer, gteq?: 0)
        required(:bscore).filled(:integer, gteq?: 0)
        required(:hull).hash do
          required(:damage).value(:integer, included_in?: (0..7).to_a)
          required(:upgraded).filled(:bool?)
        end
        required(:new_recruits).filled(:integer, included_in?: (0..6).to_a)
        required(:halfway_trained_recruits).filled(:integer, included_in?: (0..6).to_a)

        SHIP_COMPONENT_STATUS_RANGE = [0,33,66,100]
        required(:engines).hash do
          required(:status).filled(:integer, included_in?: SHIP_COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:mining_laser).hash do
          required(:status).filled(:integer, included_in?: SHIP_COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:scout_bay).hash do
          required(:status).filled(:integer, included_in?: SHIP_COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:sick_bay).hash do
          required(:status).filled(:integer, included_in?: SHIP_COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
        required(:sensors).hash do
          required(:status).filled(:integer, included_in?: SHIP_COMPONENT_STATUS_RANGE)
          required(:upgraded).filled(:bool?)
        end
      end
      SCOUT_STATUS_DESTROYED = 0
      SCOUT_STATUS_INOPERABLE = 33
      SCOUT_STATUS_FIFTY_PERCENT = 66
      SCOUT_STATUS_OPERATIONAL = 100
      SCOUT_STATUS_RANGE = [
        SCOUT_STATUS_DESTROYED,
        SCOUT_STATUS_INOPERABLE,
        SCOUT_STATUS_FIFTY_PERCENT,
        SCOUT_STATUS_OPERATIONAL
      ]
      required(:scouts).array(:hash) do
        required(:name).filled(:string, max_size?: 10)
        required(:status).filled(:integer, included_in?: SCOUT_STATUS_RANGE)
      end
      PILOT_STATUS_HEALTHY = 100
      PILOT_STATUS_INJURED = 66
      PILOT_STATUS_KILL_IN_ACTION = 0
      PILOT_STATUS_RANGE = [
        PILOT_STATUS_HEALTHY,
        PILOT_STATUS_INJURED,
        PILOT_STATUS_KILL_IN_ACTION
      ]
      required(:pilots).array(:hash) do
        required(:name).filled(:string, max_size?: 10)
        required(:kills).filled(:integer, gteq?: 0)
        required(:status).filled(:integer, included_in?: PILOT_STATUS_RANGE)
        optional(:leaps_injured).filled(:integer, gteq?: 0)
      end
    end
  end
end
