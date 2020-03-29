require 'spec_helper'
require 'lost_ship/models/game'

module LostShip
  module Models
    RSpec.describe Game do
      let(:base_game) { load_fixture(filename: "base-game.json") }
      describe "::Schema" do
        it "validates the base game" do
          expect(Game::Schema.call(base_game)).to be_success
        end
      end
    end
  end
end
