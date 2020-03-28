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

      describe '.start' do
        let(:ship_name) { "Prometheus" }
        let(:pilot_names) { ["Artemis", "Brutus", "Circe", "Dionysus", "Enkil", "Freya"] }
        let(:scout_names) { ["Red One", "Red Two", "Red Three", "Red Four", "Red Five", "Red Six"] }

        it "is valid with ship name, scout names, and pilot names" do
          game = Models::Game.start(
            ship_name: ship_name,
            pilot_names: pilot_names,
            scout_names: scout_names
          )
          validation = described_class::Schema.call(game.to_h)
          expect(validation.errors.to_h).to be_empty
        end
      end
    end
  end
end
