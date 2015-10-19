class User < ActiveRecord::Base
  has_many :timesheets
  has_many :activities
  has_many :statements_of_work

  NULL = NullUser.new

  def create_timesheet
    new_timesheet = Timesheet.create user_id: self.id
    self.update_attributes current_timesheet_id: new_timesheet.id
    new_timesheet
  end

  def current_timesheet
    current_timesheet = Timesheet.find_by id: current_timesheet_id
    unless current_timesheet.nil?
      current_timesheet
    end
    Timesheet::NULL
  end

  def current_project
    unless current_story_card.nil?
      current_story_card.project
    end
  end

  def current_story_card
    unless current_activity.nil?
      current_activity.story_card
    end
  end

  def current_activity
    current_timesheet.current_activity
  end

end
