require_relative '../spec_helper'

RSpec.describe Temporality::AutoClose do

  context 'with auto-close enabled' do
    before  { Dog.instance_variable_get(:@temporality)[:person][:auto_close] = true }
    after   { Dog.instance_variable_get(:@temporality)[:person][:auto_close] = false }

    let(:person) { Person.create({ starts_on: Date.new(2016, 1, 1) }) }
    before { person.dogs.create({ starts_on: Date.new(2016, 1, 1) }) }

    context 'when saving a partially overlapping child' do
      let(:dog) { person.dogs.build({ starts_on: Date.new(2016, 5, 1) }) }

      it 'should successfully save the child' do
        expect { dog.save }.to change { person.dogs.count }.by(1)
      end

      it 'should have auto-closed the previous child' do
        expect { dog.save }.to change { person.dogs.first.ends_on }.from(Temporality::FUTURE_INFINITY).to(Date.new(2016, 4, 30))
      end
    end

    context 'when saving a fully overlapping child' do
      let(:dog) { person.dogs.build({ starts_on: Date.new(2016, 5, 1) }) }

      it 'should fail to save the child' do
        expect { dog.save }.to raise_error(Temporality::Violation)
      end
    end
  end

end

