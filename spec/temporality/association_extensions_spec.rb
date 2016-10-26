require_relative '../spec_helper'

RSpec.describe Temporality::AssociationExtensions do

  let(:person)  { Person.create({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 12, 31) }) }

  describe '#build' do
    let(:dog) { person.dogs.build }

    context 'when creating a child with no sibling records' do
      it 'should inherit its parents starts_on bound' do
        expect(dog.starts_on).to eql(person.starts_on)
      end

      it 'should inherit its parents ends_on bound' do
        expect(dog.ends_on).to eql(person.ends_on)
      end
    end

    context 'when creating a child with existing siblings' do
      before { person.dogs.create({ starts_on: Date.new(2016, 3, 15), ends_on: Date.new(2016, 6, 30) }) }

      it 'should not inherit its parents starts_on bound' do
        expect(dog.starts_on).to eql(Temporality::PAST_INFINITY)
      end

      it 'should not inherit its parents ends_on bound' do
        expect(dog.ends_on).to eql(Temporality::FUTURE_INFINITY)
      end
    end
  end

end

