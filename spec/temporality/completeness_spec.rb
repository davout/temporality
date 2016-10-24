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

end

