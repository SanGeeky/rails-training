# frozen_string_literal: true

# user.rb
class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
