class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    message = 'Sampai jumpa kembali!'
    flash.now[:success] = message
    render :json => {:message => message}
  end

end
