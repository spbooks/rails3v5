require 'test_helper'

class StoriesTest < ActionDispatch::IntegrationTest
  test "story submission with login" do
    get new_story_path
    byebug
    assert_response :redirect
    follow_redirect!
    assert_response :success
    post session_path, params: {
      email: 'glenn.goodrich@sitepoint.com', password: 'sekrit'
    }
    follow_redirect!
    assert_response :success
    post stories_path, params: {
      story: {
        name: 'Submission from Integration Test',
        link: 'http://test.com/'
      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end
end
