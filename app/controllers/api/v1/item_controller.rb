class Api::V1::ItemController < ApplicationController
  before_action :set_item, only: [:show]

  def index
    items = Item.all
    render json: items
  end

  def create
    item = Item.create!(item_params.merge(user: current_user))
  end

  def show
    render json: @item
  end

  private

  def item_params
    params.permit(:name, :description)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end