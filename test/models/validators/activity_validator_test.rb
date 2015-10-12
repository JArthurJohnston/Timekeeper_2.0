require_relative '../model_test_case'

class ActivityValidatorTest < ModelTestCase

  test 'activity dates are valid' do
    start = time_on 5, 15
    finish = time_on 7, 30

    assert_nothing_raised ActiveRecord::RecordInvalid do
      valid_activity = Activity.create!(start_time: start, end_time: finish)

      assert valid_activity.valid?
      assert_not_nil valid_activity
      assert_equal start, valid_activity.start_time
      assert_equal finish, valid_activity.end_time
    end

    assert_raise ActiveRecord::RecordInvalid do
      invalid_activity = Activity.create!(start_time: finish, end_time: start)
      deny invalid_activity.valid?
    end

  end

  test 'validates equal times' do
    assert_nothing_raised ActiveRecord::RecordInvalid do
      Activity.create!(start_time:time_on(5, 30), end_time: time_on(5, 30))
    end
  end

  test 'validates nil times' do
    assert_nothing_raised ActiveRecord::RecordInvalid do
      Activity.create!
    end
  end
end