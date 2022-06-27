class OrderController < ApplicationController
  include Rails.application.routes.url_helpers
  # TODO: remove this after login feature complete
  skip_before_action :verify_authenticity_token

  def show_list_onepick_order
    # TODO: remove this 'user' after login feature complete
    user = FactoryBot.build(:user)
    orders = Transaction.where(user: user).order('updated_at ASC') # data order == data transaction
    render 'list_onepick_order', locals: { orders: orders }
  end

  def show_create_onepick_order
    render 'create_onepick_order'
  end

  def create_onepick_order
    # TODO: remove this 'user' after login feature complete
    user = FactoryBot.build(:user)
    jenis_sampah = params['jenis_sampah']
    berat_sampah = params['berat']
    gambar_sampah = params['gambar']
    alamat_penjemputan = params['alamat_penjemputan']

    waste = Waste.new(user: user, jenis_sampah: jenis_sampah, berat: berat_sampah, gambar: gambar_sampah, alamat_penjemputan: alamat_penjemputan)

    if waste.valid?
      ActiveRecord::Base.transaction do
        waste.save
        order = Transaction.new(user: user, delivery_courier: nil, waste: waste, nominal_dibayar: 0, status: 'NEW')

        if order.valid?
          order.save
          flash[:message] = '✅ Berhasil menambahkan pesanan OnePick'
          send_notification_to_courier(user.nama) 
          redirect_to show_list_onepick_order_path, :status => :ok
        else
          flash[:message] = '❌ Gagal menambahkan pesanan OnePick. Data transaksi tidak valid'
          raise ActiveRecord::Rollback
          redirect_to show_create_onepick_order_path, :status => :bad_request
        end

      end
    else
      flash[:message] = '❌ Gagal menambahkan pesanan OnePick. Data Sampah tidak valid'
      redirect_to show_create_onepick_order_path, :status => :bad_request
    end
  end

  # TODO: send notification to all Kurir account
  def send_notification_to_courier(pengguna_name)
    message = "1 pesanan baru dari Pengguna '#{pengguna_name}'"
    return message
  end

  private
    def waste_params
      params.permit(:user, :jenis_sampah, :berat, :gambar, :alamat_penjemputan)
    end
end
