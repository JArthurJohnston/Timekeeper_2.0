require 'test_helper'

class Api::TimesheetApiControllerTest < ActionController::TestCase
  test "should get create" do
    post :create
    assert_response :success
  end

  test "should get show" do
    get :show, {id: 1}
    assert_response :success
  end

  test "should get update" do
    post :update, id: 1
    assert_response :success
  end

  test "should delete destroy" do
    delete :destroy, id: 1
    assert_response :success
  end


  test 'adds cors header to response' do
    get :show, id: 1
    assert_response :success
    assert_not_nil assigns(:timesheet)

    assert_equal '*', @response.headers['Access-Control-Allow-Origin']
  end

  test 'cant do anything before the user has been authenticated' do
    fail('need to figure this out')
  end
end
