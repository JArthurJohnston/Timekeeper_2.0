class NullUser < User
  include NullModel

  def current_timesheet
    Timesheet::NULL
  end

  def name
    ''
  end

end
