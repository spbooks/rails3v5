ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def get_with_user(action, args_hash = {})
    args_hash[:env] = {}
    args_hash[:env] = {"rack.session" => {"user_id" =>  users(:glenn).id} }
    get action, args_hash
  end

  def post_with_user(action, args_hash = {})
    args_hash[:env] = {}
    args_hash[:env] = {"rack.session" => {"user_id" =>  users(:glenn).id} }
    post action, args_hash
  end
end
