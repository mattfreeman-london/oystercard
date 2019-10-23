require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:start) { card.top_up(10); card.touch_in(entry_station) }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  context "balance on card" do
    it "has a balance" do
      expect(card.balance).to eq 0
    end

    it "allows you to add money to the card" do
      card.top_up(10)
      expect(card.balance).to eq(10)
    end

    it "doesn't allow you to add more money than the limit to the card" do
      expect{ card.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::BALANCE_LIMIT}.")
    end

    it "raises an error when you touch in with less than £1 balance" do
      expect{ card.touch_in(entry_station) }.to raise_error("Below £#{Oystercard::MINIMUM_BALANCE}.")
    end

    it "reduces the balance by the minimum fare" do
      start
      expect { card.touch_out(exit_station) }.to change { card.balance }.by (-1)
    end

  end

  context "touching in and out" do
    it "the card is in use" do
      expect(card.in_journey?).to eq false
    end

    it "allows you to touch in to start a journey" do
      start
      expect(card.in_journey?).to eq true
    end

    it "allows you to touch out to end a journey" do
      start
      card.touch_out(exit_station)
      expect(card.in_journey?).to eq false
    end

    it 'stores the entry station' do
      start
      expect(card.entry_station).to eq entry_station
    end

    it 'stores the exit station' do
      start
      card.touch_out(exit_station)
      expect(card.exit_station).to eq exit_station
    end

    it 'has an empty list of journeys by default' do
      expect(card.journey_history).to be_empty
    end

  end

  context 'going on a complete journey' do
    it 'checks that touching in & out creates one journey' do
      start
      card.touch_out(exit_station)
      expect(card.journey).to eq ({ :entry => entry_station, :exit => exit_station })
    end

  end

end
