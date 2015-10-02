require_relative 'controller_test_case'

class TimesheetsControllerTest < ActionController::TestCase

  test 'finds user timesheets' do
    user = User.create
    timesheet1 = Timesheet.create user_id: user.id
    timesheet2 = Timesheet.create user_id: user.id
    timesheet3 = Timesheet.create user_id: user.id

    get :index, user_id: user.id, remote: true

    assert_response :success
    assert_template 'timesheet/index.js'
  end

end
