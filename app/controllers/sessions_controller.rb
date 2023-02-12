class SessionsController < ApplicationController
  def create
    session[:user] = request.env["omniauth.auth"].slice(
      :provider,
      :uid,
      :info,
    ).to_h

    redirect_to "/"
  end

  def delete
    session[:user] = nil
    redirect_to "/"
  end
end
