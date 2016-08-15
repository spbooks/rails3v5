require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_user
  end

  teardown do
    logout_user
  end

  test "creates vote" do
    assert_difference 'stories(:two).votes.count' do
      post story_votes_path(stories(:two))
    end
  end

  test "create vote with ajax" do
    post story_votes_path(stories(:two)), xhr: true
    assert_response :success
  end

  test "redirect after vote with http post" do
    post story_votes_path(stories(:two))
    assert_redirected_to story_path(stories(:two))
  end

  test "stores user with vote" do
    post_with_user story_votes_path(stories(:two))
    stories(:two).reload
    assert_equal users(:glenn), stories(:two).votes.last.user
  end
end
