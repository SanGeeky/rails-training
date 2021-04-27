# frozen_string_literal: true

# sessions_controller.rb
class SessionsController < ApplicationController
  before_action :authenticate_user, only: %i[create]

  def create
    session[:user_id] = @user.id
    redirect_to params[:previous_url]
  end

  def destroy
    session[:user_id] = nil
    redirect_back fallback_location: root_path
  end

  private

  def authenticate_user
    @user = User.find_by email: params[:email]
    return redirect_to signin_path if @user.nil?

    @user.authenticate(params[:password]) ? @user : redirect_to(signin_path)
  end
end
