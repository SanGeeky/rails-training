# frozen_string_literal: true

# generator.rb
# Specify to Rails use only RSpec Test
Rails.application.config.generators do |generator|
  generator.test_framework :rspec
end
