class AddForeignToFollowers < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :followers, :users, column: :follower_id
  end
end
