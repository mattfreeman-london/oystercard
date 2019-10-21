require 'oystercard'

describe Oystercard do
  let(:card) {Oystercard.new}

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

end
