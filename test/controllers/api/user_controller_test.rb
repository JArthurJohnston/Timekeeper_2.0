require 'test_helper'

module Api

  class UserControllerTest < ActionController::TestCase

    def setup
      @user_id = 4567
      @user_password = '1234'
      @username = 'JSmith'
      @user = User.create(username: @username,
                          password: @user_password,
                          password_confirmation: @user_password,
                          id: @user_id)
    end

    test 'loggin in adds response to header' do
      params_hash = {username: @username, password: @user_password}
      post :login, credentials: params_hash.to_json
      assert_response :success
      assert_not_nil assigns :user

      expected_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6NDU2N30.MgfwFDt027jQ6xVyrq9-nTfppxIQRcishy4NvE7Xs58'

      assert_equal '*', @response.headers['Access-Control-Allow-Origin']
      assert_equal expected_token, @response.body
    end

    test 'login returns unauthorized with incorrect password' do
      params_hash = {username: @username, password: 'this is not the password youre looking for'}
      post :login, credentials: params_hash.to_json
      assert_response :unauthorized

      assert_empty @response.body
    end

    test 'login return not found with incorrect username' do
      params_hash = {username: 'this is not the user youre looking for', password: @user_password}
      post :login, credentials: params_hash.to_json
      assert_response 404

      assert_empty @response.body
    end

  end


end