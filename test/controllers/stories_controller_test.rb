require 'test_helper'

class StoriesControllerTest < ActionDispatch::IntegrationTest
  test "gets stories" do
    get stories_path
    assert_response :success
    assert response.body.include?("A random link")
  end

  test "gets new story form" do
    get new_story_path
    assert_response :success
  end

  test "new shows new form" do
    get new_story_path
    assert_select 'form div', count: 2
  end

  test "adds a story" do
    assert_difference 'Story.count' do
      post stories_path, params: {
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
      post stories_path, params: {
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
end
