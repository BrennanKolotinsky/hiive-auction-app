class Api::V1::ItemController < ApplicationController
  def index
    items = Item.all
    render json: items
  end

  def create
    item = Item.create!(item_params.merge(user: current_user))
  end

  private

  def item_params
    params.permit(:name, :description)
  end
end