class FixFollowersColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :followers, :follower, :follower_id
  end
end
