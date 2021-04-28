# frozen_string_literal: true

# user.rb
class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :followers, dependent: :destroy
  has_many :follows, foreign_key: :follower_id, class_name: 'Follower', dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  def follow_user?(user_id)
    follows.find_by(user_id: user_id)
  end
end
