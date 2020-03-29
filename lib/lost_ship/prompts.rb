require "dry/inflector"
require 'lost_ship/prompts/start'
module LostShip
  # The interactive prompt for information and action
  module Prompts
    def self.run(prompt, **kwargs)
      class_name = Dry::Inflector.new.classify(prompt)
      const_get(class_name).run(**kwargs)
    end
  end
end
