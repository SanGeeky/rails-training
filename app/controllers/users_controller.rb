# frozen_string_literal: true

# users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return redirect_to signup_path unless @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect_to root_path
  end

  private

  def user_params
    p params
    params.require(:user).permit(:email,
                                :username,
                                :first_name,
                                :last_name,
                                :password,
                                :password_confirmation)
  end
end
