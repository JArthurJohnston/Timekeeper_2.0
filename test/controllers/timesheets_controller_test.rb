require_relative 'controller_test_case'

class TimesheetsControllerTest < ActionController::TestCase

  test 'finds user timesheets' do
    user = User.create
    timesheet1 = Timesheet.create user_id: user.id
    timesheet2 = Timesheet.create user_id: user.id
    timesheet3 = Timesheet.create user_id: user.id

    get :index, user_id: user.id

    assert_response :success
    assert_template 'index'
    assert assigns(:timesheets)
    assert assigns(:user)

    response_timesheets = @controller.instance_variable_get(:@timesheets)
    response_user = @controller.instance_variable_get(:@user)

    assert_equal [timesheet1, timesheet2, timesheet3], response_timesheets
    assert_equal user, response_user
  end

end
