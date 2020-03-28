require 'spec_helper'
RSpec.describe LostShip do
  it "has a version number" do
    expect(LostShip::VERSION).not_to be nil
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
