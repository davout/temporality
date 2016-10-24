require_relative '../spec_helper'

RSpec.describe Temporality::Overlap do

  let(:person) { Person.create({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 12, 31) }) }
  before { person.dogs.create({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 6, 30) }) }

  context 'when a record already exists' do
      let(:dog) { person.dogs.new({ ends_on: Date.new(2016, 11, 30) }) }

    context 'when overlapping is forbidden' do
      context 'when creating a non overlapping record' do
        before { dog.starts_on = Date.new(2016, 10, 1) }

        it 'should save the record correctly' do
          expect { dog.save }.to change { Dog.count }.by(1)
        end
      end

      context 'when creating an overlapping child' do
        before { dog.starts_on = Date.new(2016, 2, 1) }

        it 'should raise an exception' do
          expect { dog.save }.to raise_error(Temporality::Violation)
        end
      end
    end

    context 'when overlapping is allowed' do
      before { Dog.instance_variable_get(:@temporality)[:person][:prevent_overlap] = false }

      context 'when creating an overlapping record' do
        before { dog.starts_on = Date.new(2016, 2, 1) }

        it 'should save the record correctly' do
          expect { dog.save }.to change { Dog.count }.by(1)
        end
      end
    end

  end

end

