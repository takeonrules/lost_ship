require "dry/inflector"
require 'lost_ship/views/status_view'
require 'lost_ship/views/scouts_and_pilots_view'
module LostShip
  # Things we write to the terminal, not necessarily seeking input
  module Views
    def self.render(view_name, **kwargs)
      class_name = Dry::Inflector.new.classify("#{view_name}_view")
      const_get(class_name).render(**kwargs)
    end
  end
end
