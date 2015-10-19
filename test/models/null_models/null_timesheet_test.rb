require_relative '../model_test_case'
class NullTimesheetTest < ModelTestCase

  def setup
    @null_timesheet = Timesheet::NULL
  end

  test 'current activity returns null activity' do
    assert_equal Activity::NULL, @null_timesheet.current_activity
  end

  test 'activities are empty' do
    assert_equal [], @null_timesheet.activities
  end

  test 'dates are both today' do
    assert_equal DateTime.now, @null_timesheet.start_date
    assert_equal DateTime.now, @null_timesheet.through_date
  end

  test 'story cards are empty' do
    assert_equal [], @null_timesheet.story_cards
  end

  test 'total hours is 0' do
    assert_equal 0 , @null_timesheet.total_hours
  end

  test 'days returns today, with empty activities' do
    days = @null_timesheet.days
    assert_equal 1, days.length
    assert_empty days[0].activities
  end

end