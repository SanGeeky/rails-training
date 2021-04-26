# frozen_string_literal: true

# user.rb
class User < ApplicationRecord
  attr_accessor :password
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
end
