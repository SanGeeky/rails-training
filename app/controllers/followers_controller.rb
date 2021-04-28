# frozen_string_literal: true

# followers_controller.rb
class FollowersController < ApplicationController
  before_action :authorized

  def create
    follow = Follower.create(follow_params)
    follow.save
    redirect_article
  end

  def destroy
    follow = Follower.find_by(follow_params)
    return not_found if follow.nil?
    follow.destroy
    redirect_article
  end

  private

  def follow_params
    follow = params.permit(:user_id)
    follow.merge(follower_id: session[:user_id])
  end

  def redirect_article
    redirect_back(fallback_location: articles_url)
  end
end
