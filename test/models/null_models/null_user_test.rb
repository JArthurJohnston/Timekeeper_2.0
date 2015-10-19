require_relative '../model_test_case'

class NullUserTest < ModelTestCase

  def setup
    @null_user = User::NULL
  end

  test 'name is empty' do
    assert_equal '', @null_user.name
  end

  test 'current timesheet returns null timesheet' do
    assert_equal Timesheet::NULL, @null_user.current_timesheet
  end

  test 'current activity returns null activity' do
    assert_equal Activity::NULL, @null_user.current_activity
  end

  test 'current story card returns null story card' do
    assert_equal StoryCard::NULL, @null_user.current_story_card
  end

  test 'activities are empty' do
    assert_equal [], @null_user.activities
  end

  test 'sows are empty' do
    assert_equal [], @null_user.statements_of_work
  end

  test 'timesheets are empty' do
    assert_equal [], @null_user.timesheets
  end

end