class OrderController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show_list_onepick_order
    user = current_user
    orders = Waste.where(user: user).order('created_at DESC') # data order == data waste
    respond_to do |format|
      format.json { render json: send_success('✅ Berhasil menampilkan daftar pesanan', orders) }
      format.html { render 'list_onepick_order', locals: { orders: orders }}
    end
  end

  def show_create_onepick_order
    render 'create_onepick_order'
  end

  def create_onepick_order
    user = current_user
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
          send_notification_to_courier(user.nama) 
          flash[:message] = '✅ Berhasil menambahkan pesanan OnePick'

          respond_to do |format|
            format.json { render json: send_success('✅ Berhasil menambahkan pesanan OnePick', order) }
            format.html { redirect_to show_list_onepick_order_path, :status => :ok }
          end
        else
          raise ActiveRecord::Rollback
          flash[:message] = '❌ Gagal menambahkan pesanan OnePick. Data transaksi tidak valid'

          respond_to do |format|
            format.json { render json: send_failed('❌ Gagal menambahkan pesanan OnePick. Data transaksi tidak valid', nil), :status => :bad_request }
            format.html { redirect_to show_create_onepick_order_path, status: :bad_request }
          end
        end

      end
    else
      flash[:message] = '❌ Gagal menambahkan pesanan OnePick. Data Sampah tidak valid'
      respond_to do |format|
        format.json { render json: send_failed('❌ Gagal menambahkan pesanan OnePick. Data Sampah tidak valid', nil), :status => :bad_request }
        format.html { redirect_to show_create_onepick_order_path, status: :bad_request }
      end
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
