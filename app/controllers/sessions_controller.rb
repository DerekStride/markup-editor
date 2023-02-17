class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    session[:user] = request.env["omniauth.auth"].slice(
      :provider,
      :uid,
      :info,
      :credentials,
    ).to_h

    redirect_to "/"
  end

  def delete
    session[:user] = nil
    redirect_to "/"
  end
end
