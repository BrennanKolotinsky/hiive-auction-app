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
      expect(JSON.parse(response.body)).to eq([item.as_json])
    end
  end
end
