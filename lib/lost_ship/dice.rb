module LostShip
  module Dice
    def Dice(d6:, mod: 0)
      -> { (1..d6).inject(mod) { rand(6) + 1 } }
    end
  end
end
