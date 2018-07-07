class SessionController < ApplicationController
  def create
    if user = User.where(handle: params[:username]).first_or_create
      self.current_user = user
      redirect_to session[:return_to] || "/"
    else
      flash[:error] = "Womp womp, sorry. :("
      render "new"
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end
end
