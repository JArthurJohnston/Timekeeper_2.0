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

  def assert_order_equal expected_collection, actual_collection, fail_message = ''
    assert_equal expected_collection.length, actual_collection.length, 'collections have different sizes'
    for i in 0..expected_collection.length do
      assert_equal expected_collection[i], actual_collection[i], order_error_msg_at(i)
    end
  end

  def order_error_msg_at index
    'collections differ at location '.concat(index.to_s)
  end

  def create_user
    password = rand(1000).to_s
    return User.create(password: password, password_confirmation: password)
  end

  def create_story_card
    project = Project.create
    number = rand(100).to_s
    StoryCard.create(project_id: project.id, number: number)
  end

end