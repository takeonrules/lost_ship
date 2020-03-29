module LostShip
  module Screens
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
