class Activity < ActiveRecord::Base
  include DateTimeHelper
  include ActivityValidator
  include HasUserAccess
  extend FindNullModel

  validate :start_comes_before_end

  belongs_to :story_card
  belongs_to :timesheet
  belongs_to :user

  NULL = NullActivity.new
  BILLING_CYCLE = 15.0 * 60

  def self.now timesheet_id, story_card_id
    return Activity.new(start_time: DateTime.now,
                           timesheet_id: timesheet_id,
                           story_card_id: story_card_id)
  end

  def initialize attributes = nil, options = {}
    unless attributes.nil?
      if_not_nil_round attributes, :start_time
      if_not_nil_round attributes, :end_time
    end
    super attributes, options
  end

  def range
    return DateRange.new(self.start_time, self.end_time)
  end

  def overlaps? another_activity
    return self.range.overlaps? another_activity.range
  end

  def display_string
    "%{story_card} - %{range}" % {story_card: story_card.project_number, range: range.display_string}
  end

  def total_time
    end_time = self.end_time
    start_time = self.start_time
    unless start_time.nil?
      time_for_ending = end_time.nil? ? DateTime.now.rounded_to_fifteen_min : end_time
      return (time_in_minutes(time_for_ending) - time_in_minutes(start_time)) / 60.0
    end
    return Float::INFINITY
  end

  def timesheet
    if timesheet_id.nil?
      return Timesheet::NULL
    end
    super
  end

  def set_end_time aDateTime
    if self.end_time.nil?
      update end_time: aDateTime
    end
  end

  def set_timesheet aTimesheet
    self.timesheet_id = aTimesheet.id
    self.save
  end

  def project
    unless self.story_card.nil?
      return self.story_card.project
    end
  end

  def user
    return self.timesheet.user
  end

  def as_json(options = {})
    options[:except] = [:is_deleted]
    super(options)
  end

  private

    def if_not_nil_round attributes_passed_in, time_method_symbol
      unless attributes_passed_in[time_method_symbol].nil?
        parsed_date = parse_date_string(attributes_passed_in[time_method_symbol]).rounded_to_fifteen_min
        attributes_passed_in[time_method_symbol] = parsed_date
      end
    end

end
