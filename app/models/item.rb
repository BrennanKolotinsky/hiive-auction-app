class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def self.latest_item
    Item.all.order(created_at: :desc).first
  end

  def self.is_active_auction?
    self.latest_item.created_at + 30.seconds > Time.now
  end
end
