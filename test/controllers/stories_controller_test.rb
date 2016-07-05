require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stories_path
    assert_response :success
    puts response.body
  end
end
