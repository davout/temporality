require_relative '../spec_helper'

RSpec.describe Temporality::AttributeOverrides do

  context 'when no temporal boundaries are given' do
    let(:model) { Dummy.new }

    describe '#starts_on' do
      it 'should assign the default start value' do
        expect(model.starts_on).to eql(Temporality::PAST_INFINITY)
      end
    end

    describe '#ends_on' do
      it 'should assign the default end value' do
        expect(model.ends_on).to eql(Temporality::FUTURE_INFINITY)
      end
    end
  end

end

