class RemovePasswordsFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :password_hash, :string
    remove_column :users, :password_digest, :string
  end
end
