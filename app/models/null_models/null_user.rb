class NullUser < User

  def current_timesheet
    Timesheet::NULL
  end

  def name
    ''
  end

end
