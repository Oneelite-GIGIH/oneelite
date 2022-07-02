class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @user = User.all
    respond_to do |format|
      format.json { render json: send_success(' Berhasil menampilkan daftar user', @user) }
      format.html { render 'dashboard#index', locals: { user: @user } }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # TODO: why always getting role as PENGGUNA?
    @user = User.new(user_params)
    if @user.save
      if user_params[:role] == 1 || user_params[:role] == "1" || @user.role == 1 || @user.role == "KURIR"
        @delivery_courier = DeliveryCourier.new(user: @user)
        @delivery_courier.save
      end
      flash[:success] = "Welcome to the Oneelite!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:nama, :no_hp, :email, :alamat, :role.to_s.to_i, :password, :password_confirmation)
    end

end
