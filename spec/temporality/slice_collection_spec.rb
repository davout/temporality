require 'spec_helper'

RSpec.describe Temporality::SliceCollection do

  it 'should correctly report its size' do
    s = Temporality::SliceCollection.new
    expect(s.size).to eql(0)

    s << Temporality::Slice.new(Date.today, Date.today + 1, 0)
    expect(s.size).to eql(1)

    s << Temporality::Slice.new(Date.today + 3, Date.today + 4, 0)
    expect(s.size).to eql(2)
  end
end
