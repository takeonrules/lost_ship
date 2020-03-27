require 'spec_helper'
require 'lost_ship/dice'
require 'lost_ship/tables/threat'

module LostShip
  module Tables
    RSpec.describe Threat do
      describe '.for' do
        it "returns a Threat" do
          expect(described_class.for(leap: 1)).to be_a described_class
        end
      end
    end
  end
end
