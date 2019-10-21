require 'oystercard'

describe Oystercard do
  it "has a balance" do
    card = Oystercard.new
    expect(card.balance).to eq "£1"
  end

end
