class NullTimesheet < Timesheet
  include NullModel

  def activities
    []
  end

  def start_date
    DateTime.now
  end

  def through_date
    DateTime.now
  end

  def current_activity
    Activity::NULL
  end

  def days
    [TimesheetDay.new(self, DateTime.now)]
  end
end