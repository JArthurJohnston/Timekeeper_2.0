class User < ActiveRecord::Base
  extend FindNullModel

  has_many :timesheets
  has_many :activities
  has_many :statements_of_work
  has_many :team_members


  NULL = NullUser.new

  def create_timesheet
    new_timesheet = Timesheet.create user_id: self.id
    self.update current_timesheet_id: new_timesheet.id
    new_timesheet
  end

  def current_timesheet
    timesheet = Timesheet.find_by id: current_timesheet_id
    unless timesheet.nil?
      return timesheet
    end
    Timesheet::NULL
  end

  def current_project
      current_story_card.project
  end

  def current_story_card
      current_activity.story_card
  end

  def current_activity
    current_timesheet.current_activity
  end

  def display_string
    name
  end

  def timesheet_deleted timesheet
    if current_timesheet == Timesheet::NULL
      unless timesheets.empty?
        self.update(current_timesheet_id: timesheets.last.id)
      end
    end
  end

  def projects
  #   for now, just add a projects method to sows. that sql will be much easier to write
  #   then just iterate over a users sows and add oall of their projects to
  #   a list here on user.
  end

end
