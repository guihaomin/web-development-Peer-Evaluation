require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  test "writeevaluation should be a success" do
    get :writeevaluation
    assert_response :success
  end

  test "completeevaluation should be a redirect" do
    eval = Eval.create(writerID: 2, recieverID: 4, projectID: 2, groupID: 1)
    user = User.create
    post :completeevaluation, params: {'id' => eval.id}
    assert_response :redirect

  end

  test "newgroup should be redirect" do
    get :newgroup
    assert_response :redirect
  end


  test "show should be redirect" do
    user = User.create(loginID: "martinus.1", name: "Daniel Martinus", user_type: "student", password: "apples")
    get :show, params: {'id' => user.id}
    assert_response :redirect
  end
  

end
