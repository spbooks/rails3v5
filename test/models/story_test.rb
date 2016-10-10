require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  test "is not valid without a name" do
    s = Story.create(
      name: nil,
      link: 'http://www.testsubmission.com/'
    )
    assert s.errors[:name].any?
    refute s.valid?
  end

  test "is not valid without a link" do
    s = Story.create(name: 'My test submission', link: nil)
    assert s.errors[:link].any?
    refute s.valid?
  end

  test "is valid with required attributes" do
    s = users(:glenn).stories.create(
      name: 'My test submission',
      link: 'http://www.testsubmission.com/')
    assert s.valid?
  end

  test "returns highest vote first" do
    highest_id = stories(:one).votes.map(&:id).max
    assert_equal highest_id, stories(:one).votes.latest.first.id
  end

  test "return 3 latest votes" do
    10.times { stories(:one).votes.create(user: users(:glenn)) }
    assert_equal 3, stories(:one).votes.latest.size
  end

  test "is associated with a user"do
    assert_equal users(:glenn), stories(:one).user
  end
end
