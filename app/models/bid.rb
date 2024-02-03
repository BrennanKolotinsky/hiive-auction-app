class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validate :auction_active?, on: :create

  private

  def auction_active?
    unless item.auction_active?
      errors.add(:auction_ended, "the auction has closed")
    end
  end
end
