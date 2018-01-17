require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  test 'valid group' do
    group = Group.new(name: 'Seg Faults', group_type: '1')
    assert group.valid?
  end

  test 'group invalid without name' do
    group = Group.new(group_type: '1')
    assert_not group.valid?, 'group is valid without a name'
    assert_not_nil group.errors[:name], 'no validation error for name present'
  end

  test 'group invalid without type' do
    group = Group.new(name: 'Seg Faults')
    refute group.valid?, 'group is valid without a type'
    assert_not_nil group.errors[:group_type], 'no validation error for type present'
  end

  test 'group duplicate name invalid' do
    group = Group.new(name: 'Seg Faults', group_type: '1')
    group_dup = Group.new(name: 'Seg Faults', group_type: '1')
    group.save
    refute group_dup.valid?, 'group valid even though already duplicate'
    assert_not_nil group.errors[:name], 'no validation error for duplicate name'
  end

end
