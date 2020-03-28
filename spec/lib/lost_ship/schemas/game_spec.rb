require 'spec_helper'
require 'lost_ship/schemas/game'

module LostShip
  module Schemas
    RSpec.describe Game do
      let(:base_game) { load_fixture(filename: "base-game.json") }
      it "validates the base game" do
        expect(Game.call(base_game)).to be_success
      end
    end
  end
end
