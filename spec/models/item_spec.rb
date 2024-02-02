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
      item1 = create(:item, user: user)
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
end
