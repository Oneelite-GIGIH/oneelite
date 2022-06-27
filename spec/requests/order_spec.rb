require 'rails_helper'

RSpec.describe "Orders", type: :request do
  context 'Order Controller' do

    describe 'GET /order/onepick/new' do
      it '[controller.order.1] it should show create order page' do

        get '/order/onepick/new'

        expect(response).to have_http_status(:success)
        expect(response).to render_template :create_onepick_order
      end
    end

    describe 'POST /order/onepick/new' do
      it '[controller.order.2] it should save the new order into the database if waste & transaction data are valid' do
        user = FactoryBot.build(:user)
        valid_attributes_waste = FactoryBot.attributes_for(:waste)

        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Waste, :count).by(1)
        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Transaction, :count).by(1)

        post "/order/onepick/new", params: valid_attributes_waste

        expect(response).to have_http_status(:success)
        expect(flash[:message]).to eq('✅ Berhasil menambahkan pesanan OnePick')
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end

      it '[controller.order.3] it should return error & not save the order into the database if waste data is not valid' do
        user = FactoryBot.build(:user)
        valid_attributes_waste = FactoryBot.attributes_for(:waste, jenis_sampah: nil)

        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Waste, :count).by(0)
        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Transaction, :count).by(0)

        post "/order/onepick/new", params: valid_attributes_waste

        expect(response).to have_http_status(:bad_request)
        expect(flash[:message]).to eq('❌ Gagal menambahkan pesanan OnePick. Data Sampah tidak valid')
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end

      it '[controller.order.4] it should return error & not save the order into the database if transaction data is not valid' do
        user = FactoryBot.build(:user)
        valid_attributes_waste = FactoryBot.attributes_for(:waste, berat: nil) # transaction need waste, so if waste is not valid, either transaction

        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Waste, :count).by(0)
        expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Transaction, :count).by(0)

        post "/order/onepick/new", params: valid_attributes_waste

        expect(flash[:message]).to eq('❌ Gagal menambahkan pesanan OnePick. Data Sampah tidak valid')
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end
    end

    describe 'GET /order/onepick' do
      it '[controller.order.5] it should show page list of onepick order' do

        get '/order/onepick'

        expect(response).to have_http_status(:success)
        expect(response).to render_template :list_onepick_order
      end
    end

  end
end
