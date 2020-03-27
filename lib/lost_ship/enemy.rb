module LostShip
  module Enemy
    class Base
      attr_reader :hit_points, :number_of_attacks, :rounds_of_fuel
    end

    class Mk1 < Base
      def initialize
        @hit_points = 2
        @number_of_attacks = 1
        @rounds_of_fuel = 3
      end
    end

    class Mk2 < Base
      def initialize
        @hit_points = 5
        @number_of_attacks = 2
        @rounds_of_fuel = 4
      end
    end

    class Mk3 < Base
      def initialize
        @hit_points = 8
        @number_of_attacks = 4
        @rounds_of_fuel = 5
      end
    end
  end
end
