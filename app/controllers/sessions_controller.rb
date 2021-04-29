# frozen_string_literal: true

# sessions_controller.rb
class SessionsController < ApplicationController
  before_action :find_user, only: :create
  before_action :logged_in, only: :new

  def create
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'Welcome Back to Articles on Rails'
      redirect_to params[:previous_url]
    else
      flash[:error] = 'Incorrect email or password, please try again.'
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'See you soon on Rails!'
    redirect_back fallback_location: root_path
  end

  private

  def find_user
    @user = User.find_by(email: params[:email])
  end
end
