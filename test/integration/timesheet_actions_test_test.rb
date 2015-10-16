require 'test_helper'

class TimesheetActionsTestTest < ActionDispatch::IntegrationTest

  test 'destroy timesheet action' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    activity = Activity.create(timesheet_id: timesheet.id, user_id: user.id)

    delete user_timesheet_path(user.id, timesheet.id)

    assert_nil Timesheet.find_by(id: timesheet.id)
    assert_nil Activity.find_by(id: activity.id)

    assert_response :success
    asseert_template 'index'
  end

end
