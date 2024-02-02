class Item < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def self.latest_item
    Item.all.order(created_at: :desc).first
  end
end
