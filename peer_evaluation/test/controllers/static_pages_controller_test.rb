require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest


  test "should get users page" do
    get '/users'
    assert_response :success

  end

  test "should get login page" do
    get '/login'
    assert_response :success

  end

  test "should get register page" do
    get '/register'
    assert_response :success

  end

  test "should get about page" do
    get '/about'
    assert_response :success

  end

  test "should get contact page" do
    get '/contact'
    assert_response :success

  end

end
