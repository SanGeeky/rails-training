class RemoveArticleFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :user, null: false, foreign_key: true
  end
end
