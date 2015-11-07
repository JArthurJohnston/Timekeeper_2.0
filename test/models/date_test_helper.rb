module DateTestHelper


  def monday
    return DayWrapper.new 2015, 11, 2
  end

  def tuesday
    return DayWrapper.new 2015, 11, 3
  end

  def wednesday
    return DayWrapper.new 2015, 11, 4
  end

  def thursday
    return DayWrapper.new 2015, 11, 5
  end

  def friday
    return DayWrapper.new 2015, 11, 6
  end

  def saturday
    return DayWrapper.new 2015, 11, 7
  end

  def sunday
    return DayWrapper.new 2015, 11, 8
  end

  class DayWrapper
    attr_accessor :year, :month, :day
    def initialize year, month, day
      @year = year
      @month = month
      @day = day
    end

    def at(hour, minute= 0)
      return DateTime.new(@year, @month, @day, hour, minute, 0)
    end

    def next
      self.class.new year, month, day + 7
    end
  end
end