# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    unless current_user
      flash[:alert] = "You aren't authorized to visit that page."
      redirect_to '/'
    end
  end

  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
