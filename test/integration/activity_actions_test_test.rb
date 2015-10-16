require 'test_helper'

class ActivityActionsTestTest < ActionDispatch::IntegrationTest

  test 'destroy activity action' do
    user = User.create
    timesheet = Timesheet.create(user_id: user.id)
    activity = Activity.create(user_id: user.id, timesheet_id: timesheet.id)
    deleted_activity_id = activity.id

    delete user_timesheet_activity_path(user.id, timesheet.id, activity.id)

    assert_response :success
    assert_template :index

    assert_nil Activity.find(deleted_activity_id)
  end

end
