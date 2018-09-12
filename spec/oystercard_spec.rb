require 'oystercard'

describe Oystercard do

let(:entry_station) { instance_double("Station", :name => "Charring Cross", :zone => 1) }
let(:exit_station) { instance_double("Station", :name => "King's Cross", :zone => 1) }
let(:min_balance) { Oystercard::MINIMUM_BALANCE }
let(:max_balance) { Oystercard::MAXIMUM_BALANCE }
let(:min_fare) { Oystercard::MINIMUM_FARE }

  describe "#balance" do
    
    it 'returns an initial @balance of 0' do
      expect(subject.balance).to eq(0)
    end

  end

  describe "#top_up" do

    it 'updates the balance when passed a value' do

      value = rand(1..50)

      expect{subject.top_up(value)}.to change{subject.balance}.by(value)

    end

    it 'fails if @balance will go over MAXIMUM_BALANCE' do

      value = max_balance + 1

      expect{subject.top_up(value)}.to raise_error("Value exceeds maximum allowed: #{max_balance}")

    end

  end

  describe '#touch_in' do
    
    it "checks that the journey has started" do

      subject.top_up(min_balance)
      subject.touch_in(entry_station)

      expect(subject).to be_in_journey

    end

    it 'fails when @balance is below MINIMUM_BALANCE' do
      expect { subject.touch_in(entry_station) }.to raise_error('Balance too low')
    end

    it 'sets the starting station' do
      
      subject.top_up(max_balance)
      subject.touch_in(entry_station)

      expect(subject.journey_history[-1][:entry_station]).to eq(entry_station)

    end
    
  end

  describe '#touch_out' do

    it "checks the journey has finished" do

      subject.top_up(max_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject).to_not be_in_journey

    end

    it "deducts journey fare from @balance" do

      subject.top_up(max_balance)
      subject.touch_in(entry_station)

      expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by(-min_fare)

    end

    it 'adds @entry_station and end_station to @journey_history' do

      subject.top_up(max_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.journey_history).to eq([{
        entry_station: entry_station, 
        exit_station: exit_station
      }])

    end

  end

  describe '#in_journey?' do

    it 'shows whether a card is in journey' do

      subject.top_up(max_balance)
      subject.touch_in(entry_station)

      expect(subject).to be_in_journey

    end

    it 'shows whether a card is in journey' do

      subject.top_up(max_balance)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject).not_to be_in_journey

    end

  end

end