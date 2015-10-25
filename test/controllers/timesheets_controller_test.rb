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

  test 'show assigns non-deleted activities'
  user = User.create
  timesheet = Timesheet.create user_id: user.id
  act1 = Activity.create(timesheet_id: timesheet.id)
  act1.destroy
  act2 = Activity.create(timesheet_id: timesheet.id)
  act3 = Activity.create(timesheet_id: timesheet.id)

  get :show, user_id: user.id, timesheet_id: timesheet.id

  assert_response :success
  assert assigns :activities

end
