require 'test_helper'

class ApiIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @user_id = 4567
    @user_password = '1234'
    @username = 'JSmith'
    @user = User.create(username: @username,
                        password: @user_password,
                        password_confirmation: @user_password,
                        id: @user_id)
    @token = UserToken.for(@user)
    https!
  end

  def json_header
    return {'Content-Type' => 'application/json'}
  end

  def authorization_header
    {authorization: @token}
  end

  def all_headers
    {
        authorization: @token,
        'Content-Type' => 'application/json'
    }
  end
end