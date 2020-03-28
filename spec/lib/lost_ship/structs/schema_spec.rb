require 'spec_helper'
require 'lost_ship/structs/schema'

module LostShip
  module Structs
    RSpec.describe Schema do
      let(:base_game) { load_fixture(filename: "base-game.json") }
      it "validates the base game" do
        expect(Schema.call(base_game)).to be_success
      end
    end
  end
end
