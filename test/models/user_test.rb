require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "has a story association" do
    assert_equal 2, users(:glenn).stories.size
    assert users(:glenn).stories.includes stories(:one)
  end

  test "has a votes association" do
    assert_equal 1, users(:glenn).votes.size
    assert users(:john).votes.includes votes(:two)
  end
end
