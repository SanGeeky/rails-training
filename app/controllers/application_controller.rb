# frozen_string_literal: true

# application_controller.rb
class ApplicationController < ActionController::Base
  def not_found
    raise ActionController::RoutingError, 'Not Found'
  end
end
