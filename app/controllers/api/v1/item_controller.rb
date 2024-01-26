class Api::V1::ItemController < ApplicationController
  def index
    items = Item.all
    render json: items
  end
end