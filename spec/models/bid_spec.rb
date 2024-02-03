require 'rails_helper'

RSpec.describe Bid, type: :model do
  let!(:owner) { create(:user) }
  let!(:product) { create(:item, user: owner) }
  let!(:bidder) { create(:user) }

  describe '#amount' do
    let(:bid) { create(:bid, item: product, user: bidder, amount: 1) }

    it 'is valid when an amount is set' do
      expect(bid.valid?).to eq(true)
    end

    it 'is not valid when an amount is NOT set' do
      expect { bid.update(amount: nil) }.to raise_error(ActiveRecord::NotNullViolation)
    end
  end

  describe '#user' do
    let(:bid) { create(:bid, item: product, user: bidder, amount: 1) }

    it 'is valid when a user is set' do
      expect(bid.valid?).to eq(true)
    end

    it 'is not valid when a user is NOT set' do
      bid.update(user: nil)
      expect(bid.valid?).to eq(false)
    end
  end

  describe '#item' do
    let(:bid) { create(:bid, item: product, user: bidder, amount: 1) }

    it 'is valid when an item is set' do
      expect(bid.valid?).to eq(true)
    end

    it 'is not valid when an item is NOT set' do
      bid.update(item: nil)
      expect(bid.valid?).to eq(false)
    end
  end

  describe '#create' do
    it 'throws an error when trying to create a bid after the auction has ended' do
      product.update(created_at: Time.now - 31)
      failed_bid = Bid.new(user: bidder, amount: 1, item: product)
      expect(failed_bid).to be_invalid
      expect(failed_bid.errors[:auction_ended]).not_to be_empty
    end
  end

  describe '#minimum_bid' do
    it 'if the current bid is less than 10, the next bed must be current bid + 1' do
      bid = create(:bid, item: product, user: bidder, amount: 5)
      expect(bid.minimum_bid).to eq(bid.amount + 1)
    end

    it 'if the current bid is less than 100, the next bed must be current bid + 1' do
      bid = create(:bid, item: product, user: bidder, amount: 55)
      expect(bid.minimum_bid).to eq(bid.amount + 1)
    end

    it 'if the current bid is 100, the next bed must be 110' do
      bid = create(:bid, item: product, user: bidder, amount: 100)
      expect(bid.minimum_bid).to eq(110)
    end

    it 'if the current bid is less than 1000 but greater than 100, the next bed must be current bid + 10' do
      bid = create(:bid, item: product, user: bidder, amount: 155)
      expect(bid.minimum_bid).to eq(bid.amount + 10)
    end

    it 'if the current bid is less than 10000 but greater than 1000, the next bed must be current bid + 100' do
      bid = create(:bid, item: product, user: bidder, amount: 1555)
      expect(bid.minimum_bid).to eq(bid.amount + 100)
    end
  end
end
