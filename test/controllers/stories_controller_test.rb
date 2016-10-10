require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test "gets stories" do
    get stories_path
    assert_response :success
    assert response.body.include?("A random link")
  end

  test "gets new story form" do
    get_with_user new_story_path
    assert_response :success
    assert_select 'form div', count: 2
  end

  test "adds a story" do
    assert_difference 'Story.count' do
      post_with_user stories_path, params: {
        story: {
          name: 'test story',
          link: 'http://www.test.com/'
        }
      }
    end
    assert_redirected_to stories_path
    assert_not_nil flash[:notice]
  end

  test "rejects when missing story attribute" do
    assert_no_difference 'Story.count' do
      post_with_user stories_path, params: {
        story: { name: 'story without a link' }
      }
    end
  end

  test "show story" do
    get story_path(stories(:one))
    assert_response :success
    assert response.body.include?(stories(:one).name)
  end

  test "show story vote elements" do
    get story_path(stories(:one))
    assert_select 'h2 span#vote_score'
    assert_select 'ul#vote_history li', count: 2
    assert_select 'div#vote_form form'
  end

  test "indicates logged in user" do
    get_with_user stories_path
    assert_select 'div#login_logout em a', '(Logout)'
  end

  test "indicates not logged in" do
    get stories_path
    assert_select 'div#login_logout em', 'Not logged in.'
  end

  test "show navigation menu" do
    get stories_path
    assert_select 'ul#navigation li', 2
  end

  test "redirects if not logged in" do
    get new_story_path
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "show story submitter" do
    get story_path(stories(:one))
    assert_select 'p.submitted_by span', 'Glenn Goodrich'
  end

  test "stores user with story" do
    post_with_user stories_path, params: {
      story: {
        name: 'story with user',
        link: 'http://www.story-with-user.com/'
      }
    }
    assert_equal users(:glenn), Story.last.user
  end
end
