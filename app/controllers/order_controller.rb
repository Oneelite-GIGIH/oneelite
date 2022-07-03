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

  def show_transaction_history
    user = current_user
    transactions = Transaction.where(user: user).order('created_at DESC')
    respond_to do |format|
      format.json { render json: send_success('✅ Berhasil menampilkan histori transaksi', transactions) }
      format.html { render 'transaction_history', locals: { transactions: transactions } }
    end
  end

  def show_all_transactions
    transactions = Transaction.all()
    respond_to do |format|
      format.json { render json: send_success('✅ Berhasil menampilkan semua pesanan', transactions), :status => :ok }
      format.html { render 'list_all_transactions', locals: { transactions: transactions }, :status => :ok }
    end
  end

  def change_transaction_status
    new_status = params[:new_status]
    transaction_id = params[:transaction_id]
    transaction = Transaction.find(transaction_id)

    if transaction.nil?
      respond_to do |format|
        format.json { render json: send_failed('❌ Gagal mengganti status', transactions), :status => :bad_request }
        format.html { redirect_to show_all_transactions_path , :status => :bad_request }
      end
    end

    transaction.update(status: new_status)
    respond_to do |format|
      format.json { render json: send_success('✅ Berhasil memperbarui status pesanan', transaction), :status => :ok }
      format.html { redirect_to show_all_transactions_path, :status => :ok }
    end
  end

  def confirm_transaction
    transaction_id = params[:transaction_id]
    transaction = Transaction.find(transaction_id)

    if transaction.nil?
      respond_to do |format|
        format.json { render json: send_failed('❌ Gagal mengganti status', transactions), :status => :bad_request }
        format.html { redirect_to show_all_transactions_path , :status => :bad_request }
      end
    end

    # TODO: find a way to handle nominal_bayar
    nominal_bayar = 10000
    transaction.update(status: "PAID", nominal_dibayar: nominal_bayar)
    user = User.find(transaction.user.id)
    new_user_saldo = user.saldo + nominal_bayar
    user.update_column(:saldo, new_user_saldo)

    respond_to do |format|
      format.json { render json: send_success('✅ Berhasil mengkonfirmasi transaksi', transaction), :status => :ok }
      format.html { redirect_to show_all_transactions_path, :status => :ok }
    end
  end

  private
    def waste_params
      params.permit(:user, :jenis_sampah, :berat, :gambar, :alamat_penjemputan)
    end
end
