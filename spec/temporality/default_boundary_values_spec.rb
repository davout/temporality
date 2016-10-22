require_relative '../spec_helper'

RSpec.describe Temporality::DefaultBoundaryValues do

  context 'when the record is saved with its default values' do
    let(:model) { Dummy.new }
    before { model.save! }

    describe '#starts_on' do
      it 'should be set with the default start value' do
        expect(model.starts_on).to eql(Temporality::PAST_INFINITY)
      end
    end

    describe '#ends_on' do
      it 'should be set with the default end value' do
        expect(model.ends_on).to eql(Temporality::FUTURE_INFINITY)
      end
    end
  end

end

