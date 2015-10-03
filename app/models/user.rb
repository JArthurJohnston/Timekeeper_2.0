class User < ActiveRecord::Base
  has_many :timesheets
  has_many :activities
  has_many :statements_of_work

  def create_new_timesheet
    new_timesheet = Timesheet.create user_id: self.id
    self.update_attributes current_timesheet_id: new_timesheet.id
    new_timesheet
  end

  def current_timesheet
    Timesheet.find current_timesheet_id
  end

end
