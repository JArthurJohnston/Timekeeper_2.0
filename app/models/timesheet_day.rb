class TimesheetDay
  attr_reader :timesheet, :date

  def initialize aTimesheet, aDate
    @timesheet = aTimesheet
    @date = aDate
  end

  def activities
     activities = @timesheet.activities
     return activities.select { |e|
       same_days? e.start_time.to_datetime.new_offset(0), @date.to_datetime.new_offset(0)
     }
  #   This could definitely be done better in sql
  end

  def same_days? aDate, anotherDate
    return date_without_time(aDate) == date_without_time(anotherDate)
  end

  def date_without_time aDate
    return DateTime.new(aDate.year, aDate.month, aDate.day)
  end

  def display_string
    return @date.strftime('%A %B %-d %Y')
  end

  def timesheet_id
    return @timesheet.id
  end

end