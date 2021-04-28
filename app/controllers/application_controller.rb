# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorized
    redirect_to signin_path unless session[:user_id]
  end

  def logged_in
    redirect_to root_path if session[:user_id]
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
