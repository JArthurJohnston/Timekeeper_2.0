class DateRange
  include DateTimeHelper

  attr_reader :start ,:finish

  def initialize(start, finish)
    @start = start
    @finish = finish
  end

  def contains?(date_time)
    unless date_time.nil? || @start.nil? || @finish.nil?
      return @start < date_time && @finish > date_time
    end
    return false
  end

  def overlaps? date_range
    return contains_range_times?(date_range) || date_range.contains_range_times?(self) || self == date_range
  end

  def is_after? date_range
    unless self.start.nil?
      unless date_range.finish.nil?
        return self.start > date_range.finish
      else
        return true
      end
    end
    return false
  end

  def contains_range_times?(date_range)
    return self.contains?(date_range.start) || self.contains?(date_range.finish)
  end

  def valid?
    return @start <= @finish
  end

  def == another_date_range
    return self.start == another_date_range.start && self.finish == another_date_range.finish
  end

  def display_string
    return '%{start} to %{end}' % {:start => time_string_for(@start),
                                   :end => time_string_for(@finish)}
  end

  def total_time_in_minutes
    return time_in_minutes(finish) - time_in_minutes(start)
  end

    private
      def time_or_now_for  aTime
        if aTime.nil?
          return DateTime.now
        else
          return aTime
        end
      end

end