class Timesheet < ActiveRecord::Base
  include CurrentActivity, TimesheetDisplay
  extend DateTimeHelper
  extend FindNullModel

  NULL = NullTimesheet.new

  has_many :activities, -> { order(:start_time) }, dependent: :destroy
  belongs_to :user

  def add_activity anActivity
    unless self.current_activity_id.nil?
      self.current_activity.set_end_time anActivity.start_time
    end
    anActivity.set_timesheet self
    update current_activity_id: anActivity.id
  end

  def days
    currentDate = self.start_date.to_datetime.new_offset(0)
    through_date = self.through_date.to_datetime.new_offset(0)
    theDays = [self.on(currentDate)]
    while currentDate < through_date
      currentDate += 1.day
      theDays.push(self.on(currentDate.new_offset(0)))
    end
    return theDays
  end

  def on aDate
    return TimesheetDay.new(self, aDate)
  end

  def story_cards
    cards = []
    self.activities.each do |each_activity|
      story_card = each_activity.story_card
      unless cards.include? story_card
        cards.push(story_card)
      end
    end
    return cards
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

end
