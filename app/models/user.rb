class User < ActiveRecord::Base
  include TeamAccessableFields
  extend FindNullModel

  has_many :timesheets
  has_many :activities
  has_many :statements_of_work
  has_many :team_members

  has_secure_password

  after_create :create_private_team

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

  private

  def create_private_team
    new_team = Team.create(user_id: self.id, name: 'Personal')
    TeamMember.create(team_id: new_team.id, user_id: self.id, is_admin: true)
  end

end
