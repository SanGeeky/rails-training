# frozen_string_literal: true

# sessions_controller.rb
class SessionsController < ApplicationController
  before_action :logged_in, only: :new
  before_action :authenticate_user, only: %i[create]

  def create
    session[:user_id] = @user.id
    flash[:notice] = 'Welcome Back to Articles on Rails'
    redirect_to params[:previous_url]
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'See you soon on Rails!'
    redirect_back fallback_location: root_path
  end

  private

  def authenticate_user
    @user = User.find_by email: params[:email]
    flash[:error] = 'Email not found on Rails!'
    return redirect_to signin_path if @user.nil?

    flash[:error] = "Incorrect password for user: #{@user.username}."
    @user.authenticate(params[:password]) ? @user : redirect_to(signin_path)
  end
end
