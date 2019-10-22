require 'oystercard'

describe Oystercard do
  let(:card) {Oystercard.new}
  let(:station) { double :station}

  context "balance on card" do
    it "has a balance" do
      expect(card.balance).to eq 0
    end

    it "allows you to add money to the card" do
      card.top_up(1)
      expect(card.balance).to eq(1)
    end

    it "doesn't allow you to add more money than the limit to the card" do
      expect{ card.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::BALANCE_LIMIT}.")
    end

    it "raises an error when you touch in with less than £1 balance" do
      expect{ card.touch_in(station) }.to raise_error("Below £#{Oystercard::MINIMUM_BALANCE}.")
    end

    it "reduces the balance by the minimum fare" do
      expect { card.touch_out }.to change { card.balance }.by (-1)
    end

  end

  context "being on a journey" do
    it "the card is in use" do
      expect(card.in_journey?).to eq false
    end

    it "allows you to touch in to start a journey" do
      card.top_up(20)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    it "allows you to touch out to end a journey" do
      card.touch_out
      expect(card.in_journey?).to eq false
    end

    it 'stores the entry station' do
      card.top_up(10)
      card.touch_in(station)
      expect(card.entry_station).to eq station
    end

  end

end
