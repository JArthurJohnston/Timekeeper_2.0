require 'test_helper'

module Api

  class UserControllerTest < ActionController::TestCase

    def setup
      @user_password = '1234'
      @username = 'JSmith'
      @user = User.create(username: @username,
                          password: @user_password,
                          password_confirmation: @user_password)
    end

    test 'loggin in adds response to header' do
      params_hash = {username: @username, password: @user_password}
      post :login, credentials: params_hash.to_json
      assert_response :success
      assert_not_nil assigns :user

      assert_equal '*', @response.headers['Access-Control-Allow-Origin']
      assert_equal '{token}', @response.body
    end
  end


end