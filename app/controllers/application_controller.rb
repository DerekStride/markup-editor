class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def authenticate_user!
    return if current_user
    redirect_to "/"
  end

  helper_method def current_user
    @current_user ||= session[:user]&.yield_self { |u| User.new(u) }
  end

  def github = current_user.github
end
