class UsersController < ApplicationController

  def new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user && logged_in?(@user)
      render :show
    else
      redirect_to new_sessions_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password)
  end

end
