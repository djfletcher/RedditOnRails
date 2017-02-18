class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  helper_method :login!, :current_user, :log_out!, :logged_in?, :require_user_be_moderator

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?(user)
    session[:session_token] == user.session_token
  end

  def require_user_be_moderator
    @sub = Sub.find(params[:id])
    moderator = @sub.moderator
    unless moderator == current_user
      flash.now[:errors] = ["Tough noogies. Only the moderator can edit a sub. THIS ISN'T ANARCHY. No matter how beautiful a non-competitive classless harmonious social organization may look."]
      render :show
    end
  end

end
