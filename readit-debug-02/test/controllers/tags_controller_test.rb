require 'test_helper'

class TagsControllerTest < ActionDispatch::IntegrationTest
  test "renders tagged stories" do
    stories(:one).tag_list = 'blog, ruby'
    stories(:one).save
    get tag_path("ruby")
    assert_response :success
    assert_select 'div#content div.story', count: 1 
  end
end
