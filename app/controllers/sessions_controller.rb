class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.validate_credentials(params[:user][:user_name], params[:user][:password])

    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid log in credentials"]
      render :new
    end
  end

  def destroy
    @user = current_user

    if @user
      log_out!(@user)
    else
      flash[:errors] = ["Not currently logged in"]
    end
    redirect_to new_sessions_url
  end

end
