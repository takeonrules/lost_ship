require "dry/inflector"
require 'lost_ship/prompts/start_prompt'
require 'lost_ship/prompts/launch_assignment_prompt'
module LostShip
  # The interactive prompt for information and action
  module Prompts
    def self.run(prompt, **kwargs)
      class_name = Dry::Inflector.new.classify("#{prompt}_prompt")
      const_get(class_name).run(**kwargs)
    end
  end
end
