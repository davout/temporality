require_relative '../spec_helper'

RSpec.describe Temporality::AssociationExtensions do

  # TODO Try with keyword args, when passing a starts_on and ends on it shouldn't override

  let(:person)  { Person.create({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 12, 31) }) }

  describe '#build' do
    let(:dog) { person.dogs.build }

    context 'when building a child' do
      context 'with no siblings' do
        it 'should inherit its parents starts_on bound' do
          expect(dog.starts_on).to eql(person.starts_on)
        end

        it 'should inherit its parents ends_on bound' do
          expect(dog.ends_on).to eql(person.ends_on)
        end
      end

      context 'with existing siblings' do
        before { person.dogs.create({ starts_on: Date.new(2016, 3, 15), ends_on: Date.new(2016, 6, 30) }) }

        it 'should set starts_on on the child as the date following ends_on on the previous sibling' do
          expect(dog.starts_on).to eql(Date.new(2016, 7, 1))
        end

        it 'should inherit its parents ends_on bound' do
          expect(dog.ends_on).to eql(person.ends_on)
        end
      end

      context 'with an incompatible sibling' do
        before { person.dogs.create({ starts_on: Date.new(2016, 3, 15), ends_on: Date.new(2016, 12, 31) }) }

        it 'should not inherit its parents starts_on bound' do
          expect(dog.starts_on).to eql(Temporality::PAST_INFINITY)
        end

        it 'should inherit its parents ends_on bound' do
          expect(dog.ends_on).to eql(person.ends_on)
        end
      end
    end
  end

  describe '#create' do
    context 'when creating a child with defined attributes' do
      let(:dog) { person.dogs.create(starts_on: Date.new(2016, 12, 13), ends_on: Date.new(2016, 12, 15)) }

      it 'should not override the start date' do
        expect(dog.starts_on).to eql(Date.new(2016, 12, 13))
      end

      it 'should not override the end date' do
        expect(dog.ends_on).to eql(Date.new(2016, 12, 15))
      end
    end

    context 'when creating a child without defined attributes' do
      let(:dog) { person.dogs.create }

      context 'with no siblings' do
        it 'should inherit its parents starts_on bound' do
          expect(dog.starts_on).to eql(person.starts_on)
        end

        it 'should inherit its parents ends_on bound' do
          expect(dog.ends_on).to eql(person.ends_on)
        end
      end

      context 'with existing siblings' do
        before { person.dogs.create({ starts_on: Date.new(2016, 3, 15), ends_on: Date.new(2016, 6, 30) }) }

        it 'should set starts_on on the child as the date following ends_on on the previous sibling' do
          expect(dog.starts_on).to eql(Date.new(2016, 7, 1))
        end

        it 'should inherit its parents ends_on bound' do
          expect(dog.ends_on).to eql(person.ends_on)
        end
      end

      context 'with an incompatible sibling' do
        before { person.dogs.create({ starts_on: Date.new(2016, 3, 15), ends_on: Date.new(2016, 12, 31) }) }

        it 'should fail to create the child' do
          expect { dog }.to raise_error(Temporality::Violation)
        end
      end
    end
  end
end

