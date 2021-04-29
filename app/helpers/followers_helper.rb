# frozen_string_literal: true

# followers_helper.rb
module FollowersHelper
  def user_followers
    current_user.followers.map(&:follower_user)
  end
end
