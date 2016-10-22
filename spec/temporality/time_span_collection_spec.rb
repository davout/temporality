require 'spec_helper'

RSpec.describe Temporality::TimeSpanCollection do

  it 'should correctly get completing time spans for' do
    ts1 = Temporality::TimeSpan.new(Date.new(2010, 1, 15), Date.new(2010, 1, 31))
    ts2 = Temporality::TimeSpan.new(Date.new(2010, 2, 1), Date.new(2010, 2, 15))
    tsc = Temporality::TimeSpanCollection.new([ts1, ts2])
    tsfill = Temporality::TimeSpan.new(Date.new(2010, 1, 13), Date.new(2010, 2, 18))

    expect(ts1.substract(tsfill)).to be_nil
    expect(tsfill.substract(ts1)).to eql(Temporality::TimeSpanCollection.new([
      Temporality::TimeSpan.new(Date.new(2010, 1, 13), Date.new(2010, 1, 14)),
      Temporality::TimeSpan.new(Date.new(2010, 2, 1), Date.new(2010, 2, 18))
    ]))

    completing = tsfill.substract(tsc)

    expect(completing.size).to eql(2)
    expect(completing).to be_an_instance_of(Temporality::TimeSpanCollection)

    tsc_res = Temporality::TimeSpanCollection.new [
      Temporality::TimeSpan.new(Date.new(2010, 1, 13), Date.new(2010, 1, 14)),
      Temporality::TimeSpan.new(Date.new(2010, 2, 16), Date.new(2010, 2, 18))
    ]

    expect(tsc_res).to eql(completing)
  end

  it 'should intersect correctly' do
    ts1 = Temporality::TimeSpan.new(Date.new(2010, 1, 1), Date.new(2010, 1, 31))
    ts2 = Temporality::TimeSpan.new(Date.new(2010, 2, 1), Date.new(2010, 2, 28))
    ts3 = Temporality::TimeSpan.new(Date.new(2010, 1, 15), Date.new(2010, 2, 15))
    ts4 = Temporality::TimeSpan.new(Date.new(2010, 1, 15), Date.new(2010, 1, 31))
    ts5 = Temporality::TimeSpan.new(Date.new(2010, 2, 1), Date.new(2010, 2, 15))

    expect(ts1.intersect(ts2)).to be_nil

    tsc1 = Temporality::TimeSpanCollection.new(ts3).intersect(Temporality::TimeSpanCollection.new([ts1, ts2]))
    tsc2 = Temporality::TimeSpanCollection.new([ts4, ts5])

    expect(tsc1).to eql(tsc2)

    # Expect actual equality (new)
    expect(tsc1).to eql(tsc2)
  end

  it 'should check types when intersecting' do
    raised = false
    message = ''

    begin
      Temporality::TimeSpanCollection.new.intersect! ''
    rescue TypeError
      raised = true
      message = $!.message
    end

    expect(raised).to(be_truthy, 'No exception was raised!')
    expect(message).to match(/Element is not a Temporality::TimeSpan or a Temporality::TimeSpanCollection/)
  end

  it 'should check types on initialize' do
    raised = false
    message = ''

    begin
      Temporality::TimeSpanCollection.new([1, 2])
    rescue TypeError
      raised = true
      message = $!.message
    end

    expect(raised).to(be_truthy, 'No exception was raised!')
    expect(message).to match(/Element is not a Temporality::TimeSpan/)
  end

end
