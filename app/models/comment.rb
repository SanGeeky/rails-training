# frozen_string_literal: true

# comment.rb
class Comment < ApplicationRecord
  include Visible

  belongs_to :article
end
