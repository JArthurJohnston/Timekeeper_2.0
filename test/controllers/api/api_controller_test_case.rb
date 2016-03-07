require 'test_helper'

class ApiControllerTestCase < ActionController::TestCase

  def setup
    @user_id = 4567
    @user_password = '1234'
    @username = 'JSmith'
    @user = User.create(username: @username,
                        password: @user_password,
                        password_confirmation: @user_password,
                        id: @user_id)
  end



end