require 'spec_helper'
require 'lost_ship'
require 'lost_ship/actions'
module LostShip
  module Actions
    RSpec.describe CreateLaunch do
      let(:input) { "a1 b2 c3" }
      let(:game) { LostShip.load_from(filename: fixture_path(filename: "base-game.json") ) }
      let(:create_launch) { described_class.new(game: game) }

      describe "#call" do
        context "with valid data" do
          it "updates the launch section of the given game" do
            expect(create_launch.call(input: input)).to be_success
          end
        end
        context "with invalid pairing structure" do
          let(:input) { "a123" }
          it "updates the launch section of the given game" do
            expect(create_launch.call(input: input)).to be_failure
          end
        end
        context "with double pairing" do
          let(:input) { "a1 b1" }
          it "updates the launch section of the given game" do
            expect(create_launch.call(input: input)).to be_failure
          end
        end
      end
    end
  end
end
