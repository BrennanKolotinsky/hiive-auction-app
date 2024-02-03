require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#user' do
    it 'is valid with a user' do
      user = create(:user)
      item = create(:item, user: user)
      expect(item.valid?).to eq(true)
    end

    it 'is not valid without a user' do
      expect { create(:item) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#name' do
    it 'is not valid without a name' do
      user = create(:user)
      item = create(:item, user: user)
      item.update(name: nil)
      expect(item.valid?).to eq(false)
    end
  end

  describe '#self.latest_item' do
    it 'displays the latest created item' do
      user = create(:user)
      item1 = create(:item, user: user, created_at: Time.now - 31.seconds) # go back over 30 seconds to avoid validation preventing creation
      item2 = create(:item, user: user)
      expect(Item.latest_item).to eq(item2)
    end
  end

  describe '#is_active_auction?' do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }

    it 'returns that an auction is running when an item has just been put up for auction' do
      expect(Item.is_active_auction?).to eq(true)
    end

    it 'returns that an auction is no longer running when the latest auction is old' do
      item.update(created_at: Time.now - 31)
      expect(Item.is_active_auction?).to eq(false)
    end
  end

  describe '#create' do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }

    it 'throws an error when trying to create an auction, while another auction is still running' do
      failed_item = Item.new(user: user, name: 'iPad Pro', description: 'Factory sealed')
      expect(failed_item).to be_invalid
      expect(failed_item.errors[:active_auction]).not_to be_empty
    end
  end

  describe '#latest_bid' do
    let!(:user) { create(:user) }
    let!(:bidder) { create(:user) }
    let!(:bidder_2) { create(:user) }
    let!(:item) { create(:item, user: user) }
    let!(:bid) { create(:bid, item: item, user: bidder, amount: 1) }
    let!(:bid_2) { create(:bid, item: item, user: bidder_2, amount: 11) }

    it 'displays the latest bid' do
      expect(item.latest_bid).to eq(bid_2)
    end
  end

  describe '#auction_active?' do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }

    it 'returns true when auction is still running' do
      expect(item.auction_active?).to eq(true)
    end

    it 'returns false when auction finishes running' do
      item.update(created_at: Time.now - 31)
      expect(item.auction_active?).to eq(false)
    end
  end
end
