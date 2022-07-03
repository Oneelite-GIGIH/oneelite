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
      # it '[controller.order.2] it should save the new order into the database if waste & transaction data are valid' do
      #   post "/users", :params => { :user => { :nama => "Pengguna 1", :no_hp => "08123123123", :email => "pengguna1@oneelite.com", :alamat => "Jl. Jalan 1", :password => "12341234", :password_confirmation => "12341234", :role => 0 } }

      #   post "/login", :params => { :user => { :email => "pengguna1@oneelite.com", :password => "12341234" } }

      #   valid_attributes_waste = FactoryBot.attributes_for(:waste)

      #   expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Waste, :count).by(1)
      #   expect{post "/order/onepick/new", params: valid_attributes_waste}.to change(Transaction, :count).by(1)

      #   post "/order/onepick/new", params: valid_attributes_waste

      #   expect(response).to have_http_status(:success)
      #   expect(flash[:message]).to eq('✅ Berhasil menambahkan pesanan OnePick')
      #   expect(response.content_type).to eq("text/html; charset=utf-8")
      # end

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

    describe 'GET /order/history' do
      it '[controller.order.6] it should show transactions history page' do

        get '/order/history'

        expect(response).to have_http_status(:success)
        expect(response).to render_template :transaction_history
      end
    end

    describe 'GET /transactions' do
      it '[controller.order.7] it should show all transactions' do

        get '/transactions'

        expect(response).to have_http_status(:success)
        expect(response).to render_template :list_all_transactions
      end
    end

    describe 'POST /transactions/:transaction_id/:new_status' do
      # it '[controller.order.8] it should change the transaction status' do
      #   user = User.new(nama: "Nama Test 2", no_hp: "+62 881234567", email: "test2@gmail.com", role: 0, saldo: 99.999, alamat: "Test Jalan 2")
      #   waste = Waste.new(user: user, jenis_sampah: "Makanan Sisa", berat: 3, gambar: "/transaction/gambar/sampah_1.png", alamat_penjemputan: "Jl. Test 2")
      #   delivery_courier = DeliveryCourier.new(user: user)
      #   transaction = Transaction.new(user: user, waste: waste, delivery_courier: delivery_courier, nominal_dibayar: 10000, status: 0)

      #   post '/transactions/:transaction_id/:new_status', params: { transaction_id: transaction.id, new_status: 'DELIVERED' }

      #   expect(response).to have_http_status(:success)
      # end
    end

  end
end
