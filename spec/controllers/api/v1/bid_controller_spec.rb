require 'rails_helper'

RSpec.describe Api::V1::BidController, type: :controller do

  describe "POST #create" do
    let!(:user) { create(:user) }
    let!(:item) { create(:item, user: user) }
    before { allow(controller).to receive(:current_user) { user } }

    it "returns http success" do
      params = {amount: 1, item_id: item.id}
      expect { post :create, params: params }.to change{ Bid.count }.by(1)
    end
  end
end
