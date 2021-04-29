# frozen_string_literal: true

# comment.rb
class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user

  validates :commenter, presence: true
  validates :body, presence: true, length: { minimum: 5 }
end
