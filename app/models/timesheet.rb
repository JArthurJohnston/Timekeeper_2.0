class Timesheet < ActiveRecord::Base
  include CurrentActivity,
          TimesheetDisplay,
          TimesheetCSV
  extend DateTimeHelper,
         FindNullModel

  NULL = NullTimesheet.new

  has_many :activities, -> { order(:start_time) }, dependent: :destroy
  belongs_to :user

  def add_activity anActivity
    unless current_activity == Activity::NULL
      self.current_activity.update(end_time: anActivity.start_time)
    end
    anActivity.set_timesheet(self)
    anActivity.save
  end

  def current_activity
    unless activities.empty?
      return activities.last
    end
    Activity::NULL
  end

  def days
    current_date = self.start_date.to_datetime.new_offset(0)
    through_date = self.through_date.to_datetime.new_offset(0)
    theDays = [self.on(current_date)]
    while current_date.to_date < through_date.to_date
      current_date += 1.day
      theDays.push(self.on(current_date.new_offset(0)))
    end
    return theDays
  end

  def on aDate
    return TimesheetDay.new(self, aDate)
  end

  def story_cards
    return StoryCard.joins(:activities).uniq
  end

  def start_date
    unless activities.empty?
      return activities.first.start_time
    end
    DateTime.now
  end

  def through_date
    unless activities.empty?
      return activities.last.start_time
    end
    DateTime.now
  end

  def total_hours
    total = 0
    activities.each do
    |each_activity|
      total += each_activity.total_time
    end
    total
  end

  def destroy
    super
    user.timesheet_deleted(self)
  end

  def user
    if self.user_id.nil?
      return User::NULL
    end
    super
  end
end
