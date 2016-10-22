require_relative '../spec_helper'

RSpec.describe Temporality::Validation do

  context 'when the start date is after the end date' do
    let(:model) { Dummy.new({ starts_on: Date.new(2016, 12, 31), ends_on: Date.new(2016, 1, 1) }) }

    it 'should raise en exception when saving the model' do
      expect { model.save }.to raise_error(Temporality::Violation)
    end
  end

  context 'when the parent time range does not fully overlap' do
    let(:person) { Person.new({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 12, 31) }) }
    let(:dog) { person.dogs.build({ starts_on: Date.new(2015, 1, 1), ends_on: Date.new(2017, 12, 31) }) }

    context 'when the parent is unsaved' do
      before { dog }

      it 'should raise an exception' do
        expect { person.save }.to raise_error(Temporality::Violation)
      end
    end

    context 'when the parent is saved' do
      before { person.save }

      it 'should raise an exception when saving the child' do
        expect { dog.save }.to raise_error(Temporality::Violation)
      end
    end

  end

end

