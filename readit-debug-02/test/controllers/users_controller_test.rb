require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "show user" do
    get user_path(users(:glenn))
    assert_response :success
    assert response.body.include?(users(:glenn).name)
  end

  test "show submitted stories" do
    get user_path(users(:glenn))
    assert_select 'div#stories_submitted div.story', count: 2
  end

  test "show stories voted on" do
    get user_path(users(:glenn))
    assert_select 'div#stories_voted_on div.story', count: 1
  end
end
