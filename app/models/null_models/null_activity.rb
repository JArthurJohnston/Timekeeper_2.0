class NullActivity < Activity
  include NullModel

  def start_time
    DateTime.now
  end

  def end_time
    DateTime.now
  end

  def user
    User::NULL
  end

  def story_card
    StoryCard::NULL
  end

  def timesheet
    Timesheet::NULL
  end
end