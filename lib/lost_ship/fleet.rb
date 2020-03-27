module LostShip
  module Fleet
    class ColonyShip
      def initialize(name:, fuel: 6, parts: 6)
        @name = name
        @fuel = fuel
        @parts = parts
        @bscore = 0
        @leaps_since_incident = 0
        @new_recruits = 0
        @halfway_trained = 0
        @hull = Hull.new
        @sick_bay = SickBay.new
        @engines = Engines.new
        @mining_laser = MiningLaser.new
        @sensors = Sensors.new
        @scouting_bay = ScoutingBay.new
        @pilots = (1..6).map do |i|
          Pilot.new(name: "Pilot #{i}")
        end
      end
      attr_reader :pilots, :new_recruits, :halfway_trained, :name, :bscore, :fuel, :parts, :hull, :sick_bay, :engines, :mining_laser, :sensors, :scouting_bay, :leaps_since_incident

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
        @kills = 3
        @leaps_injured = 0
      end
      attr_reader :name, :kills, :leaps_injured

      def to_s
        attributes = []
        if kills >= 6
          attributes << "Ace"
        elsif kills >= 3
          attributes << "Vet"
        end
        if kills > 0
          attributes << "K#{kills}"
        end
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
