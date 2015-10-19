class NullUser < User

  def current_timesheet
    Timesheet::NULL
  end

  def activities
    []
  end

  def statements_of_work
    []
  end

  def timesheets
    []
  end

  def name
    ''
  end

end