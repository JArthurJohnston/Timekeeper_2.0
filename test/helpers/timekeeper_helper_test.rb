require_relative '../../test/models/model_test_case'

class TimekeeperHelperTest < ModelTestCase

  test 'update activity timezones' do
    start1 = time_on(13, 15)
    end1 = time_on(17, 15)
    act1 = Activity.create(start_time: start1, end_time: end1)

    TimekeeperHelpers.update_activity_timezones_to '-5'

    expected_start = start1.new_offset('-5')
    expected_end = end1.new_offset('-5')
    updated_activity = Activity.find act1.id

    assert expected_start.eql?(updated_activity.start_time)
    assert expected_end.eql?(updated_activity.end_time)
  end
end