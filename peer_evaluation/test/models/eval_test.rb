require 'test_helper'

class EvalTest < ActiveSupport::TestCase

  test "is valid eval" do
    eval = Eval.new(comments: 'He is great!', score: 5, writerID: 2, recieverID: 4, projectID: 2, groupID: 1)
    assert eval.valid?
  end

  test "is invalid eval without groupID" do
    eval = Eval.new(comments: 'He is great!', score: 5, writerID: 2, recieverID: 4, projectID: 2)
    assert_not eval.valid?
  end

  test "is invalid eval without projectID" do
    eval = Eval.new(comments: 'He is great!', score: 5, writerID: 2, recieverID: 4, groupID: 1)
    assert_not eval.valid?
  end
end
