require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test "creates vote" do
    assert_difference 'stories(:two).votes.count' do
      post_with_user story_votes_path(stories(:two))
    end
  end

  test "create vote with ajax" do
    post_with_user story_votes_path(stories(:two)), xhr: true
    assert_response :success
  end

  test "redirect after vote with http post" do
    post_with_user story_votes_path(stories(:two))
    assert_redirected_to story_path(stories(:two))
  end
end
