# frozen_string_literal: true

# user.rb
class User < ApplicationRecord
  attr_accessor :password
  attr_writer :password_salt, :password_hash

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates_confirmation_of :password
  before_save :encrypt_password

  def encrypt_password
    @password_salt = BCrypt::Engine.generate_salt
    @password_hash = BCrypt::Engine.hash_secret(password, @password_salt)
  end

  def self.authenticate(email, password)
    user = User.find_by 'email = ?', email
    user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
  end
end
