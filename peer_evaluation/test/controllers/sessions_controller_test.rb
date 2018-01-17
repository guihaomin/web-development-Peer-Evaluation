require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest

  test "should destroy post" do
    delete '/logout'
    assert_response :redirect
  end



end
