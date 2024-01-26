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
end
