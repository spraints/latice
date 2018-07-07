class ApplicationController < ActionController::Base
  def require_user
    if !logged_in?
      session[:redirect_to] = request.url
      render "session/new"
    end
  end

  helper_method \
  def logged_in?
    current_user.present?
  end

  helper_method \
  def current_user
    return @current_user if defined?(@current_user)
    @current_user =
      if id = session[:user_id]
        User.where(id: id).first
      end
  end

  def current_user=(user)
    session[:user_id] = user.id
    @current_user = user
  end
end
