require_relative '../spec_helper'

RSpec.describe Temporality::Completeness do

  before  { Dog.instance_variable_get(:@temporality)[:person][:completeness] = true }
  after   { Dog.instance_variable_get(:@temporality)[:person][:completeness] = false }

  let(:person)  { Person.create({ starts_on: Date.new(2016, 1, 1), ends_on: Date.new(2016, 12, 31) }) }
  let(:dog)     { person.dogs.new({ starts_on: person.starts_on }) }

  context 'when saving a temporally complete child' do
    before { dog.ends_on = Date.new(2016, 12, 31) }

    it 'should save the child successfully' do
      expect { dog.save }.to change { Dog.count }.by(1)
    end
  end

  context 'when saving a temporally incomplete child' do
    before { dog.ends_on = Date.new(2016, 5, 31) }

    it 'should fail to save the child successfully' do
      expect { dog.save }.to raise_error(Temporality::Violation)
    end
  end

  context 'when having invalid state temporarily inside a transaction block' do
    before do
      dog.ends_on = person.ends_on
      dog.save
    end

    context 'when the state is valid at the end of the transaction' do
      before do
        @transaction = Proc.new do
          Temporality.transaction do
            coco = person.dogs.first
            coco.ends_on = Date.new(2016, 6, 30)
            coco.save

            snoopy = person.dogs.build
            snoopy.starts_on = Date.new(2016, 7, 1)
            snoopy.ends_on = Date.new(2016, 12, 31)
            snoopy.save
          end
        end
      end

      it 'should successfully save the second child record' do
        expect(&@transaction).to change { person.dogs.count }.by(1)
      end

      it 'should not raise an error' do
        expect(&@transaction).to_not raise_error
      end
    end

    context 'when the state is invalid at the end of the transaction' do
      before do
        @transaction = Proc.new do
          Temporality.transaction do
            coco = person.dogs.first
            coco.ends_on = Date.new(2016, 6, 30)
            coco.save

            snoopy = person.dogs.build
            snoopy.starts_on = Date.new(2016, 12, 1)
            snoopy.ends_on = Date.new(2016, 12, 31)
            snoopy.save
          end
        end
      end

      it 'should rollback the whole transaction' do
        expect(&@transaction).to raise_error(Temporality::Violation)
      end

      it 'should not save the second child record' do
        expect { @transaction.call rescue nil }.to_not change { person.dogs.count }
      end

      it 'should not change the first child record' do
        expect(person.dogs.first.ends_on).to eql(Date.new(2016, 12, 31))
      end
    end

  end

end

