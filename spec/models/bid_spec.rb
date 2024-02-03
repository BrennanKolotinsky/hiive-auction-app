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
end
