# frozen_string_literal: true

# follower.rb
class Follower < ApplicationRecord
  belongs_to :user
  belongs_to :follower_user,
             class_name: :User,
             foreign_key: :follower_id
end
