require_relative '../spec_helper'

RSpec.describe Temporal::Associations do

  describe '#belongs_to' do
    let(:dog_options) { Dog.instance_variable_get(:@temporality) }

    it 'should correctly set the association options' do
      expect(dog_options).to be_a(Hash)
    end

  end

end

