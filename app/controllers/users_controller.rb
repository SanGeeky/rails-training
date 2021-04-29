# frozen_string_literal: true

# users_controller.rb
class UsersController < ApplicationController
  before_action :logged_in, only: :new
  before_action :find_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Now you are on Rails Blog!'
      redirect_to root_path
    else
      flash.now[:alert] = 'There was a problem signing up.'
      render :new unless @user.valid?
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def user_params
    params.require(:user).permit(:email,
                                 :username,
                                 :first_name,
                                 :last_name,
                                 :password,
                                 :password_confirmation)
  end
end
