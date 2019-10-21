require 'oystercard'

describe Oystercard do
  it "has a balance" do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  it "allows you to add money to the card" do
    card = Oystercard.new
    card.top_up(1)
    expect(card.balance).to eq 1
  end

end
