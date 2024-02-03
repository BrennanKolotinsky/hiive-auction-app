class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validate :auction_active?, on: :create

  def minimum_bid
    current_bid = item.latest_bid&.amount || 0
    tmp_bid = current_bid
    min_increment = 1
    while (tmp_bid >= 100) do
      min_increment = min_increment * 10
      tmp_bid = tmp_bid / 10
    end

    current_bid + min_increment
  end

  private

  def auction_active?
    unless item.auction_active?
      errors.add(:auction_ended, "the auction has closed")
    end
  end
end
