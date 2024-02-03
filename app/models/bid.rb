class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validate :auction_active?, on: :create
  validate :meets_minimum_bid?, on: :create

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

  def meets_minimum_bid?
    unless minimum_bid <= amount
      errors.add(:failed_minimum_bed, "bid is too low")
    end
  end
end
