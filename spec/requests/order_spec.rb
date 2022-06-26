require 'rails_helper'

RSpec.describe "Orders", type: :request do
  context 'Order Controller' do

    describe 'GET /order/onepick' do
      it '[controller.order.1] it should show create order page' do

        get '/order/onepick'

        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /order/onepick' do
      it '[controller.order.1] it should save the new order into the database' do
        user = FactoryBot.build(:user)
        valid_attributes_waste = FactoryBot.attributes_for(:waste)

        expect{post "/order/onepick", params: valid_attributes_waste}.to change(Waste, :count).by(1)
        expect{post "/order/onepick", params: valid_attributes_waste}.to change(Transaction, :count).by(1)

        post "/order/onepick", params: valid_attributes_waste

        expect(response.body).to_not eq(nil)
        expect(flash[:message]).to eq('✅ Berhasil menambahkan pesanan OnePick')
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end
    end

  end
end
