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
end
