require_relative 'api_controller_test_case'

class Api::TimesheetControllerTest < ApiControllerTestCase

  test 'adds cors header to response' do
    get :show, id: 1
    assert_response :success

    assert_equal '*', @response.headers['Access-Control-Allow-Origin']
    assert_equal Timesheet::NULL.to_json, @response.body
  end

  test 'checks authorization token for user' do
    some_user = User.create(id:8888, username:'JTod')
    sheet1 = Timesheet.create(user_id: 8888)
    @request.env['Authorization'] = UserToken.for(some_user)

    get :show, id: sheet1.id
    assert_response :success

    assert_equal '*', @response.headers['Access-Control-Allow-Origin']
    assert_equal sheet1.to_json, @response.body
  end

  test 'creates JWT for user' do
    fail()
  end

  test 'cant do anything before the user has been authenticated' do
    fail('need to figure this out')
  end
end
