class AddArticleToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :user, null: false, foreign_key: true
  end
end
