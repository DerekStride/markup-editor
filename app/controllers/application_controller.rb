class ApplicationController < ActionController::Base
  helper_method def current_user = @current_user ||= session[:user]
end
