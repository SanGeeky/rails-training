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
    return render :new unless @user.valid?

    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
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

  def logged_in
    redirect_to root_path if session[:user_id]
  end
end
