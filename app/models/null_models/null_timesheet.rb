class NullTimesheet < Timesheet

  def activities
    []
  end

  def start_date
    DateTime.now
  end

  def through_date
    DateTime.now
  end


end