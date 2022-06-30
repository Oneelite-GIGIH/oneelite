class UsersController < ApplicationController
  def index
    @user = User.find_by(id: current_user)
    render :json => {:message => @user}
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Oneelite!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:nama, :no_hp, :email, :alamat, :password, :password_confirmation)
    end

end
