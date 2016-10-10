require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "new shows a login form" do
    get new_session_path
    assert_response :success
    assert_select 'form p', 4
  end

  test "perform user login" do
    post session_path, params: {email: 'glenn.goodrich@sitepoint.com', password: 'sekrit'}
    assert_redirected_to stories_path
    assert_equal users(:glenn).id, session[:user_id]
  end

  test "bad login fails" do
    post session_path, params: {email: 'noone@nowhere.com', password: 'user'}
    assert_response :success
    assert_nil session[:user_id]
  end

  test "redirects after login with return url" do
    get new_story_path
    assert_redirected_to new_session_path
    post session_path,
      params: {
        email: 'glenn.goodrich@sitepoint.com',
        password: 'sekrit'
      }
    assert_redirected_to new_story_path
  end

  test "logout and clear session" do
    post(
      session_path,
      params: { email: 'glenn.goodrich@sitepoint.com', password: 'sekrit' }
    )
    assert_not_nil session[:user_id]

    delete session_path
    assert_response :success
    assert_select 'h2', 'Logout successful'

    assert_nil session[:user_id]
  end
end
