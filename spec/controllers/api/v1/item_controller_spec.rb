require 'rails_helper'

RSpec.describe Api::V1::ItemController, type: :controller do

  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "returns an array of items" do
      get :index
      expected_response = item.as_json.merge({"latest_bid_amount" => 0, "latest_bid_user" => '', "auction_active" => true})
      expect(JSON.parse(response.body)).to eq([expected_response])
    end
  end

  describe "POST #create" do
    let!(:user) { create(:user) }
    before { allow(controller).to receive(:current_user) { user } }

    it "returns http success" do
      params = {name: 'iPad', description: 'Scratched'}
      expect { post :create, params: params }.to change{ Item.count }.by(1)
    end
  end

  describe "GET #show" do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }

    it "returns http success" do
      get :show, params: { id: item.id }
      expected_response = item.as_json.merge({"latest_bid_amount" => 0, "latest_bid_user" => '', "auction_active" => true})
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end
end
