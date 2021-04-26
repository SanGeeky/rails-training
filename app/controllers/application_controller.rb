# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in?
    current_user
  end

  def authorized
    redirect_to signin_path unless user_logged_in?
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
