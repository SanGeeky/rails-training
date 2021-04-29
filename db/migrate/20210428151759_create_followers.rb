class CreateFollowers < ActiveRecord::Migration[6.1]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: true
      t.bigint :follower

      t.timestamps
    end
  end
end
