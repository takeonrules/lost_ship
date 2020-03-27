module LostShip
  module Fleet
    class ColonyShip
      def initialize(name:, fuel: 6, parts: 6)
        @name = name
        @fuel = fuel
        @parts = parts
        @bscore = 0
        @leaps_since_incident = 0
        @hull = Hull.new
        @sick_bay = SickBay.new
        @engines = Engines.new
        @mining_laser = MiningLaser.new
        @sensors = Sensors.new
        @scouting_bay = ScoutingBay.new
      end
      attr_reader :name, :bscore, :fuel, :parts, :hull, :sick_bay, :engines, :mining_laser, :sensors, :scouting_bay, :leaps_since_incident

      class Hull
        def initialize
          @upgraded = false
          @damage = 0
          @name = "Hull"
        end
        attr_accessor :damage, :upgraded, :name
        def to_s
          text = "#{name}"
          text += "+" if upgraded
          text += ": #{damage} damage"
        end
      end
      class BaseSystem
        class << self
          attr_accessor :name
        end
        def initialize
          @upgraded = false
          @status = 100
        end
        attr_accessor :upgraded, :status
        def name
          self.class.name
        end
        def to_s
          text = "#{name}"
          text += "+" if upgraded
          text += ": "
          if @status == 0
            text += "inop"
          else
            text += "#{status}%"
          end
          text
        end
      end
      class MiningLaser < BaseSystem
        self.name = "Mining Laser"
      end
      class Engines < BaseSystem
        self.name = "Engines"
      end
      class SickBay < BaseSystem
        self.name = "Sick Bay"
      end
      class Sensors < BaseSystem
        self.name = "Sensors"
      end
      class ScoutingBay < BaseSystem
        self.name = "Scouting Bay"
      end
    end

    class ScoutShip
      attr_accessor :name, :pilot
      attr_writer :damage

      DAMAGE = {
        0 => "None",
        1 => "50%",
        2 => "Inoperable",
        3 => "Destroyed"
      }
      def damage
        DAMAGE.fetch(@damage)
      end
      def to_h
        { name: name, pilot: pilot, damage: damage }
      end
    end
    class Pilot
      # Injured
      # KIA
      def initialize(name:)
        @name = name
        @kills = 0
      end
    end
  end
end
