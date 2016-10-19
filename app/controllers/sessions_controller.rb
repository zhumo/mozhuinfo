class SessionsController < ApplicationController
  def new; end

  def create
    gatekeeper = Gatekeeper.new(username: params[:username], password: params[:password])
    if gatekeeper.allow?
      session[:token] = gatekeeper.session_token
      redirect_to blogs_path
    else
      redirect_to login_path, flash: { error: 'Unable to authenticate' }
    end
  end

  def destroy
    session.delete(:token)
    redirect_to root_path, flash: { success: 'See ya!' }
  end
end
