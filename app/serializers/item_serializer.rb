class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :user_id, :created_at, :updated_at, :latest_bid_amount, :latest_bid_user

    def latest_bid_amount
      object.latest_bid&.amount || 0
    end

    def latest_bid_user
      object.latest_bid&.user&.email || ''
    end
end
