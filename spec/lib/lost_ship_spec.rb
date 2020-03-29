require 'spec_helper'
RSpec.describe LostShip do
  it "has a version number" do
    expect(LostShip::VERSION).not_to be nil
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

  describe ".load_from" do
    context 'with a valid game' do
      it 'instantiates a Game object' do
        game = described_class.load_from(filename: fixture_path(filename: "base-game.json") )
        expect(game.fleet.pilots).to be_a(Array)
      end
    end
    context 'with an invalid game' do
      it "raises an error" do
        expect do
          described_class.load_from(filename: fixture_path(filename: "invalid-game.json") )
        end.to raise_error(LostShip::InvalidGameStateError)
      end
    end
  end
end
