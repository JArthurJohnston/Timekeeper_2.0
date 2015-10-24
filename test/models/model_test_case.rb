require 'test_helper'

class ModelTestCase < ActiveSupport::TestCase

  def time_on hours, minutes
    return DateTime.new(2015, 1, 1, hours, minutes, 0, 0).new_offset(0)
  end

  def deny an_expression, fail_message = 'expected false but was true'
    assert_not_nil an_expression, "expected false but was nil"
    assert_equal false, an_expression, fail_message
  end

  def assert_times_equal a_date_time, another_date_time
    assert_equal a_date_time.to_datetime.new_offset(0), another_date_time.to_datetime.new_offset(0)
  end

  def assert_dates_are_close expectedDate, actualDate
    assert_equal expectedDate.utc.year, actualDate.utc.year
    assert_equal expectedDate.utc.month, actualDate.utc.month
    assert_equal expectedDate.utc.day, actualDate.utc.day
    assert_equal expectedDate.utc.hour, actualDate.utc.hour
    assert_equal expectedDate.utc.minute, actualDate.utc.minute
    assert_equal expectedDate.utc.second, actualDate.utc.second
  end

end