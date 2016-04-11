require_relative 'api_controller_test_case'

class Api::TimesheetApiControllerTest < ApiControllerTestCase

  test 'adds cors header to response' do
    get :show, id: 1

    assert_equal '*', @response.headers['Access-Control-Allow-Origin']
  end

  test 'checks authorization token for user' do
    sheet1 = Timesheet.create(user_id: @user.id)
    @request.env['HTTP_AUTHORIZATION'] = nil
    get :show, id: sheet1.id
    assert_response :unauthorized

    @request.env['HTTP_AUTHORIZATION'] = UserToken.for(@user)
    get :show, id: sheet1.id
    assert_response :success
  end

  test 'get show' do
    sheet1 = Timesheet.create(user_id: @user.id)
    get :show, id: sheet1.id

    assert_response :success
    assert_equal sheet1.to_json, @response.body
  end

  test 'get show not found' do
    get :show, id: 2243

    assert_response 404
  end

  test 'post create is successful' do
    assert @user.timesheets.empty?
    post :create

    assert_response :success

    new_timesheet = @user.timesheets[0]
    assert_equal new_timesheet.to_json, @response.body
  end

  test 'delete timesheet is successful' do
    sheet = Timesheet.create(user_id: @user.id)
    assert @user.timesheets.include?(sheet)

    delete :destroy, id: sheet.id
    assert_response :success

    assert @user.timesheets.empty?
    assert_equal sheet.to_json, @response.body
  end

  test 'delete timesheet is not successful' do
    sheet1 = Timesheet.create(user_id: @user.id + 2432)

    delete :destroy, id: sheet1.id
    assert_response 404

    delete :destroy, id: 24234
    assert_response 404

    assert_equal '', @response.body
  end

  test 'index action' do
    sheet1 = Timesheet.create(user_id: @user.id)
    sheet2 = Timesheet.create(user_id: @user.id)

    get :index
    assert_response :success

    assert_equal [sheet1, sheet2].to_json, @response.body
  end

end
