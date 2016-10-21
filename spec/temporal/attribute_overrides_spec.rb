require_relative '../spec_helper'

class Dummy < ActiveRecord::Base
  include Temporal
end

RSpec.describe Temporal::AttributeOverrides do

  context 'when no temporal boundaries are given' do

    let(:model) { Dummy.new.save! }

    it 'should assign the default start value' do
      expect(model.starts_on).to eql(Temporal::PAST_INFINITY)
    end

    it 'should assign the default end value' do
      expect(model.starts_on).to eql(Temporal::FUTURE_INFINITY)
    end

  end

end

