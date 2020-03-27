# require 'lost_ship/screens'; LostShip::Screens::Status.new.render
require "lost_ship/fleet"
module LostShip
  module Screens
    class Status
      def initialize(output_buffer: $stdout)
        @colony_ship = Fleet::ColonyShip.new(name: "Prometheus")
        @output_buffer = output_buffer
      end
      attr_reader :output_buffer

      TWO_COLUMN_SPRINTF = "%-39s %-40s"
      THREE_COLUMN_SPRINTF = "%-26s %-25s %-26s"
      def render
        output_buffer.puts %(        10        20        30        40        50        60        70        80)
        output_buffer.puts %(----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+)
        output_buffer.puts sprintf(
          TWO_COLUMN_SPRINTF,
          "#{@colony_ship.name} (Empathy-class)",
          "Leaps Since Incident: #{@colony_ship.leaps_since_incident}"
        )
        output_buffer.puts ""
        output_buffer.puts sprintf(
          THREE_COLUMN_SPRINTF,
          "Fuel: #{@colony_ship.fuel}",
          "Parts: #{@colony_ship.parts}",
          "B-Score: #{@colony_ship.bscore}"
        )
        output_buffer.puts ""
        output_buffer.puts sprintf(
          THREE_COLUMN_SPRINTF,
          @colony_ship.hull,
          @colony_ship.engines,
          @colony_ship.mining_laser,
        )
        output_buffer.puts sprintf(
          THREE_COLUMN_SPRINTF,
          @colony_ship.scouting_bay,
          @colony_ship.sick_bay,
          @colony_ship.sensors,
        )
      end
      #         10        20        30        40        50        60        70        80
      # ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      # Prometheus (Empathy-class)             Leaps Since Incident: 5
      #
      # Fuel: 10                 Parts: 4                  B-Score: 12
      #
      # Hull+: 2 damage          Engines+: inop            Mining Laser+: 100%, 8 kills
      # Scout Bay+: inop         Sick Bay+: inop           Sensors+: 100%
      #
      # __Scout Ships__ (10 char)               __Pilots__ (10 char)
      # a) Red One: 100%                        1) Athena: 2 kills
      # b) Red Two: 50%                         2) Freya: 18 kills, injured 2 leaps
      # c) Red Three: inop                      3) Artemis: 0 kills
      # d) Red Four: 100%                       4) Hera: 4 kills
      # e) Red Five: inop                       5) Xena: 1 kill, injured 1 leap
      # f) Red Five: 100%
      #
      # Training: 0 new recruits; 1 at 50% trained
      #
      # <include LaunchStatus>
    end

    class LaunchPrompt
      #         10        20        30        40        50        60        70        80
      # ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      # __Scout Ships__ (10 char)               __Pilots__ (10 char)
      # a) Red One: 100%                        1) Athena: 2 kills
      # b) Red Two: 50%                         2) Freya: 18 kills, injured 2 leaps
      # c) Red Three: inop                      3) Artemis: 0 kills
      # d) Red Four: 100%                       4) Hera: 4 kills
      # e) Red Five: inop                       5) Xena: 1 kill, injured 1 leap
      # f) Red Five: 100%
      #
      # Scramble Roster: __
    end

    class LaunchStatus
      #         10        20        30        40        50        60        70        80
      # ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      # Scout Bay Capacity: 5                  Available Scouts: 6
      #
      # 1) Freya (18 kills, injured 2 leaps) in Red One (100%)
      # 2) Artemis (KIA) in Red Two (Dest)
      # 3) Hera (4 kills) in Red Three (50%)
      # 4) Xena (1 kill, injured 1 leap) in Red Four (Inop)
    end

    class DamageAssignmentPrompt
      # Freya inflicts 2 damage
      #
      # <include Threat>
      # Assign to: __
    end

    class Threat
      #         10        20        30        40        50        60        70        80
      # ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      # Round 1:
      #
      # 1) MK I: XO              2) MK I: XO               3) MK I: XO
      # 4) MK II: XXXXO          5) MK III: XXXXOOOO       6) MK I: XO
    end

    class SalvageAndScan
      #         10        20        30        40        50        60        70        80
      # ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      # Anomaly: Airlock Mishap, lose 3 parts
      # Fuel: +2
      # Parts: +4
      # B-Score: +9
    end

    class RepairPrompt
      # Available Parts: 8
      #
      # 1) Repair Red One (inop): 1 part { if scout is inoperable }
      # 2) Repair 1 Hull damage: 1 part { If hull is damaged}
      # 3) Fully repair Sensor: 2 parts { Loop through systems needing repair }
      # 4) Upgrade Hull: 4 parts { Loop through non-upgraded systems }
      # 5) Build New Scout: 6 parts { If hangar less than 6}
      #
      # Upgrade: __
    end
  end
end
