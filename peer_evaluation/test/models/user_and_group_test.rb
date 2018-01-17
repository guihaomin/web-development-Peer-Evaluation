require 'test_helper'

class UserAndGroupTest < ActiveSupport::TestCase

  test "valid UserAndGroup" do
    userandgroup = UserAndGroup.new(userID: "martinus.1", groupID: "Seg Faults")
    assert userandgroup.valid?
  end

  test "invalid UserAndGroup without userID" do
    userandgroup = UserAndGroup.new(groupID: "Seg Faults")
    assert_not userandgroup.valid?
  end

  test "invalid UserAndGroup without groupID" do
    userandgroup = UserAndGroup.new(userID: "martinus.1")
    assert_not userandgroup.valid?
  end
end
