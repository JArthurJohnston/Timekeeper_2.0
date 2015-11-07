

module TimeRounding
  FIFTEEN_MINUTES = 60 * 15.0
  ONE_HOUR = 60 * 60
  ONE_DAY = ONE_HOUR * 24

  def rounded_to_fifteen_min
    timestamp = self.to_time.utc.to_i
    roundedTime = (timestamp/FIFTEEN_MINUTES).round * FIFTEEN_MINUTES
    newTime = Time.at(roundedTime).utc
    return newTime.to_datetime
  end

  def add_days aNumber
    timestamp = self.to_time.to_i
    daysToAdd = ONE_DAY * aNumber
    return Time.at(timestamp + daysToAdd).to_datetime
  end

  def next_friday
    day_index = self.to_date.cwday
    next_friday_index = 5 - day_index
    return self + next_friday_index
  end

  def to_friday
    day_index = self.to_date.cwday
    if day_index == 5
      return self
    else
      return next_friday
    end
  end

  def last_monday
    day_index = self.to_date.cwday
    prev_monday_index = day_index - 1
    return self - prev_monday_index
  end

  def to_monday
    day_index = self.to_date.cwday
    if day_index == 1
      return self
    else
      return last_monday
    end
  end
end

class DateTime
  include TimeRounding
end
