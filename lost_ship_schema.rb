require 'dry/schema'

Dry::Schema.JSON do
  required(:state).hash do
    required(:turn).filled(:integer)
  end
  required(:fleet).hash do
    required(:ship).hash do
      required(:name).filled(:string)
      required(:fuel).filled(:integer)
      required(:parts).filled(:integer)
      required(:bscore).filled(:integer)
      required(:hull).hash do
        required(:damage).value(:integer)
        required(:upgraded).filled(:boolean)
      end
      required(:engines).hash do
        required(:status).filled(:integer)
        required(:upgraded).filled(:boolean)
      end
      required(:mining_laser).hash do
        required(:status).filled(:integer)
        required(:upgraded).filled(:boolean)
      end
      required(:scout_bay).hash do
        required(:status).filled(:integer)
        required(:upgraded).filled(:boolean)
      end
      required(:sick_back).hash do
        required(:status).filled(:integer)
        required(:upgraded).filled(:boolean)
      end
      required(:sensors).hash do
        required(:status).filled(:integer)
        required(:upgraded).filled(:boolean)
      end
    end
    required(:scouts).array.schema do
      required(:name).filled(:string)
      required(:damage).filled(:integer)
    end
    required(:pilots).array.schema do
      required(:name).filled(:string)
      required(:kills).filled(:integer, gte?: 0)
      required(:status).filled(:integer)
    end
  end
end
