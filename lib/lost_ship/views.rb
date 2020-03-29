require "dry/inflector"
require 'lost_ship/views/status'
module LostShip
  # Things we write to the terminal, not necessarily seeking input
  module Views
    def self.render(view_name, **kwargs)
      class_name = Dry::Inflector.new.classify(view_name)
      const_get(class_name).render(**kwargs)
    end
  end
end
