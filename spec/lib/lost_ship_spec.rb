require 'spec_helper'
RSpec.describe LostShip do
  it "has a version number" do
    expect(LostShip::VERSION).not_to be nil
  end

  describe ".load_from" do
    context 'with a valid game' do
      it 'instantiates a Game object' do
        expect(described_class.load_from(path: fixture_path(filename: "base-game.json") )).to be_a(LostShip::Structs::Game)
      end
    end
    context 'with an invalid game' do
      it "raises an error" do
        expect do
          described_class.load_from(path: fixture_path(filename: "invalid-game.json") )
        end.to raise_error(LostShip::InvalidGameStateError)
      end
    end
  end
end
