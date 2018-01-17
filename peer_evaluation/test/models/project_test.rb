require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test 'valid project' do
    project = Project.new(name: 'Seg Faults', project_type: '1')
    assert project.valid?
  end

  test 'project invalid without name' do
    project = Project.new(project_type: '1')
    refute project.valid?, 'group is valid without a name'
    assert_not_nil project.errors[:name], 'no validation error for name present'
  end

  test 'project invalid without type' do
    project= Project.new(name: 'Seg Faults')
    refute project.valid?, 'group is valid without a type'
    assert_not_nil project.errors[:project_type], 'no validation error for type present'
  end

  test 'project duplicate name invalid' do
    project = Project.new(name: 'Seg Faults', project_type: '1')
    project_dup = Project.new(name: 'Seg Faults', project_type: '1')
    project.save
    refute project_dup.valid?, 'project valid even though already duplicate'
    assert_not_nil project.errors[:name], 'no validation error for duplicate name'
  end
end
