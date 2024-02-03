class Api::V1::BidController < ApplicationController
  def create
    bid = Bid.create!(bid_params.merge(user: current_user))
    if bid
      render json: bid
    else
      render json: bid.errors
    end
  end

  private

  def bid_params
    params.permit(:amount, :item_id)
  end
end
