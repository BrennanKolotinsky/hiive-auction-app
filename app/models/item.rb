class Item < ApplicationRecord
  belongs_to :user
  has_many :bids

  validates :name, presence: true
  validate :no_active_auction?, on: :create

  def self.latest_item
    Item.all.order(created_at: :desc).first
  end

  def self.is_active_auction?
    return false if self.count == 0
    self.latest_item.created_at + 30.seconds > Time.now
  end

  def latest_bid
    bids.order(amount: :desc).first
  end

  private

  def no_active_auction?
    unless !Item.is_active_auction?
      errors.add(:active_auction, "auction currently running")
    end
  end
end
