class SubsController < ApplicationController
  before_action :require_user_be_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    if current_user
      render :new
    else
      flash[:errors] = ["You must be logged in to create a sub"]
      redirect_to new_sessions_url
    end
  end

  def create
    @user = current_user

    if current_user
      @sub = Sub.new(sub_params)
      @sub.moderator_id = @user.id
      if @sub.save
        redirect_to sub_url(@sub)
      else
        flash.now[:errors] = @sub.errors.full_messages
        render :new
      end
    else
      redirect_to new_sub_url
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    fail
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
