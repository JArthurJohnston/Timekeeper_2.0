require 'test_helper'

class Api::ApiControllerTest < ActionController::TestCase

  test "cor preflight" do
    process :show, 'OPTIONS', controller: 'api/user'
    assert_response :success
  end


end
