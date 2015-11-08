require_relative 'model_test_case'
require_relative '../../app/models/date_range'
require_relative 'date_test_helper'

class DateRangeTest < ModelTestCase
  include DateTimeHelper, DateTestHelper

  test 'initialize' do
    time1 = time_on(5, 15)
    time2 = time_on(6, 30)

    range = DateRange.new(time1, time2)

    assert_equal(time1, range.start)
    assert_equal(time2, range.finish)
  end

  test 'range contains time' do
    time1 = time_on(5, 15)
    time2 = time_on(6, 30)
    outside_time = time_on(7, 30)
    contained_time = time_on(6, 0)

    range = DateRange.new(time1, time2)

    deny range.contains?(outside_time)
    assert range.contains?(contained_time)

    deny range.contains?(time_on(5, 15))
    deny range.contains?(time_on(6, 30))
  end

  test 'date ranges overlap' do
    time1 = time_on(5, 15)
    time2 = time_on(6, 30)
    range = DateRange.new(time1, time2)
    overlapped_range = DateRange.new(time_on(5, 30), time_on(6, 15))

    assert range.overlaps?(overlapped_range)
    assert overlapped_range.overlaps?(range)

    outside_range1 = DateRange.new(time_on(6, 30), time_on(7, 45))
    outside_range2 = DateRange.new(time_on(4, 30), time_on(5, 15))

    deny range.overlaps? outside_range1
    deny range.overlaps? outside_range2

    overlaps_start_range = DateRange.new(time_on(4, 30), time_on(5, 45))
    assert range.overlaps? overlaps_start_range

    overlaps_end_range = DateRange.new(time_on(5, 45), time_on(7, 15))
    assert range.overlaps? overlaps_end_range

    start_time = time_on(5, 45)
    finish_time = time_on(6, 45)
    dr1 = DateRange.new(start_time, finish_time)
    dr2 = DateRange.new(start_time, finish_time)
    assert dr1.overlaps? dr2

    deny dr1.overlaps?(DateRange.new(nil, nil))
  end

  test 'equality' do
    start_time = time_on(5, 45)
    finish_time = time_on(6, 45)
    dr1 = DateRange.new(start_time, finish_time)
    dr2 = DateRange.new(start_time, finish_time)

    assert dr1 == dr2

    dr3 = DateRange.new(time_on(5, 45), time_on(6, 45))
    dr4 = DateRange.new(time_on(3, 45), time_on(5, 15))

    deny dr3 == dr4
  end

  test 'date range is valid' do
    valid_range = DateRange.new(time_on(6, 30), time_on(7, 45))
    assert valid_range.valid?

    valid_range2 = DateRange.new(time_on(6, 30), time_on(6, 30))
    assert valid_range2.valid?

    invalid_range = DateRange.new(time_on(6, 30), time_on(4, 45))
    deny invalid_range.valid?
  end

  test 'range returns min or max when start and finish are nil' do
    assert_equal DateTime.new(1,1,1, 0, 0, 0), DateRange::MIN_DATE
    assert_equal DateTime.new(9999,12,31, 0, 0, 0), DateRange::MAX_DATE

    start = time_on(5, 45)
    finish = time_on(8, 45)
    d_range = DateRange.new(start, finish)

    assert_equal start, d_range.start
    assert_equal finish, d_range.finish
  end

  test 'throws an error when trying to create a range whos start is greater than its finish' do
    wrong_start = thursday.at(9)
    wrong_end = monday.at(6)

    assert_raise RuntimeError do
      DateRange.new(wrong_start, wrong_end)
    end

    assert_raise RuntimeError do
      DateRange.new(wrong_start.to_date, wrong_end.to_date)
    end
  end

  test 'total time in minutes' do
    start_time = time_on(6, 0)
    end_time = time_on(8, 15)
    expected_total_time = 135

    date_range = DateRange.new(start_time, end_time)

    assert_equal expected_total_time, date_range.total_time_in_minutes

    assert_equal 0, DateRange.new(nil, nil).total_time_in_minutes
  end

  test 'display string ' do
    start_time = time_on(6, 0)
    end_time = time_on(8, 15)

    date_range = DateRange.new(start_time, end_time)
    assert_equal '06:00 to 08:15', date_range.display_string
  end

  test 'range comes after another range' do
    range1 = DateRange.new(time_on(5, 15), time_on(6, 15))
    range2 = DateRange.new(time_on(6, 30), time_on(7, 15))

    assert range2.is_after?(range1)

    range1 = DateRange.new(time_on(5, 15), time_on(6, 15))
    range2 = DateRange.new(nil, time_on(7, 15))

    deny range2.is_after?(range1)

    range1 = DateRange.new(time_on(5, 15), nil)
    range2 = DateRange.new(time_on(6, 30), time_on(7, 15))

    assert range2.is_after?(range1)
  end

  test 'each_day iterator' do
    days_iterated_over = []
    range = DateRange.new(monday.at(5, 30), wednesday.at(6, 15))
    range.each_day do
      |e_day|
      days_iterated_over.push e_day
    end

    assert_equal 3, days_iterated_over.size
    assert_equal monday.at(1).to_date, days_iterated_over[0].to_date
    assert_equal tuesday.at(1).to_date, days_iterated_over[1].to_date
    assert_equal wednesday.at(1).to_date, days_iterated_over[2].to_date

    days_iterated_over = []
    range = DateRange.new(tuesday.at(5, 30), thursday.at(6, 15))
    range.each_day do
    |e_day|
      days_iterated_over.push e_day
    end

    assert_equal 3, days_iterated_over.size
    assert_equal tuesday.at(1).to_date, days_iterated_over[0].to_date
    assert_equal wednesday.at(1).to_date, days_iterated_over[1].to_date
    assert_equal thursday.at(1).to_date, days_iterated_over[2].to_date
  end

  test 'to work week' do
    range = DateRange.new(tuesday.at(5, 30), wednesday.at(6, 15))
    work_week_range = range.to_work_week

    assert_equal monday.at(1).to_date, work_week_range.start.to_date
    assert_equal friday.at(1).to_date, work_week_range.finish.to_date
  end

end