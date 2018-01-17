require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test 'valid user with student type' do
    user = User.new(loginID: 'martinus.1', name: 'Daniel Martinus', user_type: 'student', password_digest: 'applePie1!')
    assert user.valid?
  end

  test 'valid user with instructor type' do
    user = User.new(loginID: 'martinus.1', name: 'Daniel Martinus', user_type: 'instructor', password_digest: 'applePie1!')
    assert user.valid?
  end

  test 'invalid user without loginID' do
    user = User.new(name: 'Daniel Martinus', user_type: 'student', password_digest: 'applePie1!')
    assert_not user.valid?
  end

  test 'invalid user without user_type' do
    user = User.new(loginID: 'martinus.1', name: 'Daniel Martinus', password_digest: 'applePie1!')
    assert_not user.valid?
  end

  test 'invalid duplicate user' do
    user = User.new(loginID: 'martinus.1', name: 'Daniel Martinus', user_type: 'student', password_digest: 'applePie1!')
    user_dup = User.new(loginID: 'martinus.1', name: 'Daniel Martinus', user_type: 'student', password_digest: 'applePie1!')
    user.save
    refute user_dup.valid?, 'user valid even though already duplicate'
  end

  test 'invalid user without name' do
    user = User.new(loginID: 'martinus.1', user_type: 'student', password_digest: 'applePie1!')
    assert_not user.valid?
  end

end
