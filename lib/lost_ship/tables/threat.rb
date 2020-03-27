require 'lost_ship/dice'
module LostShip
  module Tables
    class Threat
      extend Dice
      def self.for(leap:, leap_lookup_table: DICE_FOR_LEAP_ROLL, threat_lookup_table: THREAT_LOOKUP_TABLE)
        dice = leap_lookup_table.fetch(leap)
        roll = dice.call
        if threat_lookup_table.key?(roll)
          threat_lookup_table.fetch(roll)
        else
          min = threat_lookup_table.keys.min
          max = threat_lookup_table.keys.max
          if min > roll
            threat_lookup_table.fetch(min)
          else
            threat_lookup_table.fetch(max)
          end
        end
      end

      def initialize(mk1: 0, mk2: 0, mk3: 0, homeworld: false)
        @mk1 = mk1
        @mk2 = mk2
        @mk3 = mk3
        @homeworld = homeworld
      end
      attr_reader :mk1, :mk2, :mk3, :homeworld

      DICE_FOR_LEAP_ROLL = {
        1 => Dice(d6: 2, mod: -3),
        2 => Dice(d6: 2, mod: -2),
        3 => Dice(d6: 2, mod: -1),
        4 => Dice(d6: 2),
        5 => Dice(d6: 2),
        6 => Dice(d6: 2),
        7 => Dice(d6: 2),
        8 => Dice(d6: 2, mod: 1),
        9 => Dice(d6: 2, mod: 2),
        10 => Dice(d6: 2, mod: 3),
        11 => Dice(d6: 2, mod: 4),
        12 => Dice(d6: 2, mod: 5),
        13 => Dice(d6: 2, mod: 6),
        14 => Dice(d6: 2, mod: 7),
        16 => Dice(d6: 2, mod: 8),
        17 => Dice(d6: 2, mod: 9),
        18 => Dice(d6: 2, mod: 10),
        19 => Dice(d6: 2, mod: 11),
        20 => Dice(d6: 2, mod: 12)
      }

      THREAT_LOOKUP_TABLE = {
        3 => Threat.new,
        4 => Threat.new(mk1: 4),
        5 => Threat.new(mk1: 5),
        6 => Threat.new(mk1: 6),
        7 => Threat.new(mk2: 1),
        8 => Threat.new(mk2: 1, mk1: 2),
        9 => Threat.new(mk2: 1, mk1: 3),
        10 => Threat.new(mk2: 2),
        11 => Threat.new(mk2: 2, mk1: 2),
        12 => Threat.new(mk3: 1),
        13 => Threat.new(mk3: 1, mk1: 3),
        14 => Threat.new(mk3: 1, mk2: 1),
        15 => Threat.new(mk3: 2, mk2: 2, mk1: 2, homeworld: true),
      }
    end
  end
end
