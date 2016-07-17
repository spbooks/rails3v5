require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "new shows a login form" do
    get '/session/new'
    assert_response :success
    assert_select 'form p', 4
  end

  test "perform user login" do
    post '/session', params: {email: 'glenn.goodrich@sitepoint.com', password: 'sekrit'}
    assert_redirected_to stories_path
    assert_equal users(:glenn).id, session[:user_id]
  end

  test "bad login fails" do
    post '/session', params: {email: 'noone@nowhere.com', password: 'user'}
    assert_response :success
    assert_nil session[:user_id]
  end

  test "redirects after login with return url" do
    post(
      '/session',
      params: { email: 'glenn.goodrich@sitepoint.com', password: 'sekrit' },
      env: { "rack.session" => {"return_to" => "/stories/new"}}
    )
    assert_redirected_to '/stories/new'
  end

  test "logout and clear session" do
    post(
      '/session',
      params: { email: 'glenn.goodrich@sitepoint.com', password: 'sekrit' }
    )
    assert_not_nil session[:user_id]

    delete '/session'
    assert_response :success
    assert_select 'h2', 'Logout successful'

    assert_nil session[:user_id]
  end
end
