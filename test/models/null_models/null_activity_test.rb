require_relative '../model_test_case'

class NullActivityTest < ModelTestCase

  def setup
    @null_act = Activity::NULL
  end

  test 'id is -1' do
    assert_equal -1, @null_act.id
  end

  test 'times are both now' do
    assert_dates_are_close DateTime.now, @null_act.start_time
    assert_dates_are_close DateTime.now, @null_act.end_time
  end

  test 'returns null story card' do
    assert_equal StoryCard::NULL, @null_act.story_card
  end

  test 'returns null timesheet' do
    assert_equal Timesheet::NULL, @null_act.timesheet
  end

  test 'returns null user' do
    assert_equal User::NULL, @null_act.user
  end

end